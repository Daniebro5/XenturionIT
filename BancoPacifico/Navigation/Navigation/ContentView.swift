import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            List(0 ..< 100) { i in
                Text("Row \(i)")
                    .font(.title)
            }
            .navigationTitle("Title goes here")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark)
            .toolbar(.hidden, for: .navigationBar)
        }
    }

}

#Preview {
    ContentView()
}
