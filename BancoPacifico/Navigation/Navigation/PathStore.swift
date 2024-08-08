import Foundation

final class PathStore: ObservableObject {
    var path: [Int] {
        didSet {
            save()
        }
    }

    private let savePath = URL
        .documentsDirectory
        .appending(path: "SavedPath")

    init() {
        // try? ignora el error y me envía nil si hay uno
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
                path = decoded
                return
            }
        }

        // no existió un path guardado así que lo iniciamos vacío
        path = []
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(path)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data, \(error.localizedDescription)")
        }
    }
}
