import SwiftUI

struct ContentView: View {

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            Text("Mi 4ta clase de iOS")
                .toolbar {
                    Button("Push 556") {
                        path.append(556)
                    }
                    Button("Push Hello") {
                        path.append("Hello")
                    }
                }
                .navigationDestination(for: Int.self) { destination in
                    Text("You are in \(destination)")
                }
                .navigationDestination(for: String.self) { destination in
                    Text("You are in \(destination)")
                }
        }
    }
}

// Hashable

#Preview {
    ContentView()
}
