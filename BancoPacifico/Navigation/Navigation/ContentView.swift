import SwiftUI

struct ContentView: View {

    @ObservedObject private var pathStore = PathStore()

    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailView(number: 0, path: $pathStore.path)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i, path: $pathStore.path)
                }
        }
    }
}

struct DetailView: View {

    var number: Int
    @Binding var path: NavigationPath

    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1 ... 1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
                    path = NavigationPath()
                }
            }
    }
}



// Hashable

#Preview {
    ContentView()
}
