import SwiftUI

struct ContentView: View {

    @State var name = ""

    var body: some View {
        Form {
            ForEach(0 ..< 100) {
                Text("Fila \($0)")
            }
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
