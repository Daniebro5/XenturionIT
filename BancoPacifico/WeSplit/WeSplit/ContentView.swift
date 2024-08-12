import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Hello, World!")
                }
            }
            .navigationTitle("SwiftUI")
        }

    }
}

#Preview("Light") {
    ContentView()
        .preferredColorScheme(.light)
}

#Preview("dark") {
    ContentView()
        .preferredColorScheme(.dark)
}
