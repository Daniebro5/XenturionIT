import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(0 ..< 100) { i in
                NavigationLink("Select \(i)",
                               value: Student(name: "Danni", age: i))
            }
            .navigationDestination(for: Student.self) { selection in
                Text("You selected \(selection.age)")
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
