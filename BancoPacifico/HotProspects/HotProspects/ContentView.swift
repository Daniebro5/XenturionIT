import SwiftUI

struct ContentView: View {

    let users = ["Danni", "André", "Daniela", "Rogger"]

    @State private var selection = Set<String>()

    var body: some View {
        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }
        EditButton()
        // safe unwrap - desenvoltura segura
        if !selection.isEmpty {
            Text("Seleccionaste \(selection.formatted())")
        }
    }
}

#Preview {
    ContentView()
}
