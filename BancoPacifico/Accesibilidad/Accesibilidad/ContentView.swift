import SwiftUI

struct ContentView: View {

    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var body: some View {
        if dynamicTypeSize >= .accessibility3 {
            Text("Has seleccionado una fuente mas grande")
                .padding()
        } else {
            Text("Es la fuente regular")
                .padding()
        }

    }
}

#Preview {
    ContentView()
}
