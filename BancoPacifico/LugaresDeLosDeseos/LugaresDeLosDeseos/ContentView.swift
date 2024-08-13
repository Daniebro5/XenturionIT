import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Read and Write") {
            let data = Data("Mensaje de prueba".utf8)
            let url = URL.documentsDirectory.appending(path: "mensaje.txt")

            do {
                try data.write(to: url,
                               options: [
                                .atomic,
                                    .completeFileProtection
                               ])
                let input = try String(contentsOf: url)
                print(input)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ContentView()
}
