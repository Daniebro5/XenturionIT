import Foundation
import SwiftUI

final class PathStore: ObservableObject {
    @Published var path: NavigationPath {
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
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }

        // no existió un path guardado así que lo iniciamos vacío
        path = NavigationPath()
    }

    func save() {
        guard let representation = path.codable else { return }
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data, \(error.localizedDescription)")
        }
    }
}
