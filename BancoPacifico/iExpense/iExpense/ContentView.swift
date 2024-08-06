import Combine
import SwiftUI

// tipo referencia, podemos compartir el estado en varias partes de la app
// primero poner estructura, si necesitamos: herencia, referencias (compartir estado), sobrecarga; solo ahí refactorizar al uso de clases
@Observable
class User {
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
