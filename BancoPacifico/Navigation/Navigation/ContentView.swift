import SwiftUI

struct ContentView: View {

    @State private var path = [Int]()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Show 32 then 64 then 32") {
                    path = [32, 64, 32]
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
        }
    }
}

struct Student: Hashable {
    var id = UUID()
    var name: String
    var age: Int
}

// Hashable

#Preview {
    ContentView()
}
