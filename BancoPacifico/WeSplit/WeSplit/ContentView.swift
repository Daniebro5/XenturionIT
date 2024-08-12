import SwiftUI

struct ContentView: View {

    @State var name = ""

    var body: some View {
        Form {
            // lectura y escritura (con $)
            TextField("Ingresa tu nombre", text: $name)
            // lectura (sin $)
            Text("Your name is: \(name)")
        }
    }

    // muestra el valor de la propiedad
    // name
    // muestra el valor de la propiedad y escribe los nuevos cambios si es necesario
    // two way binding (lectura - escritura)
    // $name
}

#Preview("Light") {
    ContentView()
        .preferredColorScheme(.light)
}

#Preview("dark") {
    ContentView()
        .preferredColorScheme(.dark)
}
