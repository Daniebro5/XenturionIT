import SwiftUI

struct ContentView: View {

    var body: some View {
        List {
            Text("Tierra Canela")
            // recomendaciones de swipeActions
            // como estan ocultos no ocultar info importante aqui
            // utilizar los que son por defecto al menos
                .swipeActions {
                    Button("Delete",
                           systemImage: "minus.circle",
                           role: .destructive
                    ) {
                        print("eliminando")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") {
                        print("Pinning")
                    }
                    .tint(.indigo)
                }
        }
    }
}

#Preview {
    ContentView()
}
