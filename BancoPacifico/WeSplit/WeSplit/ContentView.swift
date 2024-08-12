// le dice a Swift que queremos usar toda la funcionalidad escrita por los ingenieros de apple relacionado a SwiftUI
// CoreML - machine learning
// AVFoundation - audio y video
// CoreImage - CoreGraphics edicion de imagenes
import SwiftUI

// la estructura se "conforma" o "adhiere" al protocolo View que es de SwiftUI
// este dibuja las cosas en pantalla
struct ContentView: View {

    // sintaxis es de propiedad computada
    // las propiedades computadas se recalculan cada vez que se necesiten
    // some significa que esto va a retornar "algo" que se conforme al protocolo View
    var body: some View {
        VStack {
            // las imagenbes systemName son solo piezas de texto estatico que son dibujadas en pantalla
            Image(systemName: "globe")
            // modificadores, en programacion funcional querria decir que yo podria aplicar varios de estos devolviendo el mismo tipo o uno similar
                .imageScale(.large)
                .foregroundStyle(.tint)
                .font(.title)
            Text("Hello, world!")
                .font(.title)
        }
        .padding()
    }
}

// usa el macro #Preview, este macro no va a ser enviado a la app store cuando mandemos a produccion la app
#Preview("Light") {
    ContentView()
        .preferredColorScheme(.light)
}

#Preview("dark") {
    ContentView()
        .preferredColorScheme(.dark)
}

#Preview {
    ContentView()
}

#Preview {
    ContentView()
}

#Preview {
    ContentView()
}

#Preview {
    ContentView()
}


final class Persona {
    var altura: Double = 172
    var peso: Double = 57

    var imc: Double {
        peso / (altura * altura)
    }

    // la funcion suena más a producir efectos
    func obtenerIMC() -> Double {
        // si solo uso variables de esta clase yo utilizaría una computed property
        peso / (altura * altura)
    }
}
