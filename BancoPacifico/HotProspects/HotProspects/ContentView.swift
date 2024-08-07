import SwiftUI

struct ContentView: View {

    let users = ["Danni", "André", "Daniela", "Rogger"]

    @State private var selection: String?

    var body: some View {
        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }
        // safe unwrap - desenvoltura segura
        if let selection {
            Text("Seleccionaste \(selection)")
        }
    }
}

#Preview {
    ContentView()
}
