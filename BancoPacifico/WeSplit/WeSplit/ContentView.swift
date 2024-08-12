import SwiftUI

struct ContentView: View {

    // Las vistas son una funcion de su estado
    // es decir es la manera en que la interfaz de usuario luce, dependiendo del estado de la aplicacion

    // state me permite q esta variable sea mutabvle (algo que no se puede en las estructuras)
    // State especificamente diseñado para propiedades simples que serán almacenadas en una sola vista
    @State private var tapCount = 0

    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
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

// struct vs clase
// la estructura es inmutable
// let a = ContentView()
