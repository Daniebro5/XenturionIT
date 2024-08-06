import SwiftUI

// tipo valor, si es constante ninguna propiedad cambia
struct User {
    var primerNombre = "Danni"
    var apellido = "Brito"
}

struct ContentView: View {

    // State escucha los cambios dentro de la propiedad y redibuja la vista cada que haya un cambio
    @State private var user = User()

    var body: some View {
        VStack {
            Text("Tu nombre es \(user.primerNombre) \(user.apellido)")

            TextField("Primer Nombre", text: $user.primerNombre)

            TextField("Apellido", text: $user.apellido)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
