import SwiftUI

enum EstadoDeCarga {
    case cargando, completado, fallido
}

struct ContentView: View {

    @State private var estadoDeCarga = EstadoDeCarga.fallido

    var body: some View {
        // ventaja: Switch utiliza el compilador para saber si todos los cases han sido cubiertos, es decir si en un futuro añadimos un nuevo case, nos va a dar un error para añadirlo aquí
        switch estadoDeCarga {
        case .cargando:
            CargandoView()
        case .completado:
            CompletadoView()
        case .fallido:
            FallidoView()
        }
    }
}

struct CargandoView: View {
    var body: some View {
        Text("cargando")
    }
}

struct CompletadoView: View {
    var body: some View {
        Text("completado")
    }
}

struct FallidoView: View {
    var body: some View {
        Text("fallido")
    }
}

#Preview {
    ContentView()
}
