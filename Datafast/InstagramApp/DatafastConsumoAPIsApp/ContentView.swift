import SwiftUI

// La vista ContentView es la vista principal mostrada en la aplicación.
struct ContentView: View {
    var body: some View {
        // ZStack permite apilar vistas en el eje z, lo que significa que se superponen una sobre otra.
        ZStack {
            // Color de fondo para la vista completa.
            Color.red.edgesIgnoringSafeArea(.all)

            // VStack alinea sus vistas hijo verticalmente.
            VStack(alignment: .leading) {
                // Muestra una imagen del sistema que es redimensionable y con un tamaño específico.
                Image(systemName: "globe")
                    .resizable()
                    .frame(width: 100, height: 100)

                // Texto con estilo personalizado.
                Text("Hello, world!")
                    .foregroundStyle(.blue)
                    .font(.largeTitle) // Fuente grande predeterminada de Apple.

                // Serie de Text Views para demostrar el uso de VStack.
                Text("Este")
                Text("Es")
                Text("El")
                Text("Curso")
                    .padding(.vertical, 20) // Añade espacio vertical antes y después.

                Text("de")
                    .bold() // Texto en negrita.

                Text("desarrollo")
                    .background(Color.blue) // Fondo azul para este texto.

                Text("iOS")
                    .kerning(5) // Espaciado entre caracteres.
                    .italic() // Texto en cursiva.
                    .bold() // Texto en negrita.

                Image(systemName: "globe") // Segunda imagen del globo.

                // HStack alinea sus vistas hijo horizontalmente.
                HStack {
                    Text("La vista es larga y se ajusta en múltiples líneas.")
                        .multilineTextAlignment(.trailing) // Alineación del texto a la derecha.

                    Text("horizontal") // Texto adicional para demostrar alineación horizontal.
                }

                // HStack para alinear texto a ambos lados con un Spacer en el medio.
                HStack {
                    Text("Esto a la izquierda")
                    Spacer() // Ocupa el espacio disponible, empujando el texto a los extremos.
                    Text("Esto a la derecha")
                }
                .background(Color.green) // Fondo verde para este HStack.

                // HStack para centrar texto usando Spacers a ambos lados.
                HStack {
                    Spacer()
                    Text("Esto al centro")
                    Spacer()
                }
                .background(Color.white) // Fondo blanco para resaltar esta sección.
            }
            .padding(.horizontal, 2) // Padding horizontal para todo el VStack.
        }
    }
}

// PreviewProvider permite visualizar la interfaz diseñada en el canvas de Xcode.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Notas adicionales:
// - SwiftUI es una manera declarativa de construir interfaces de usuario, donde describimos lo que queremos
//   en lugar de cómo se debe construir.
// - Stacks (VStack, HStack) son contenedores fundamentales en SwiftUI que ayudan a organizar las vistas
//   en columnas o filas.
// - Spacer es una vista que crea espacio adicional que puede ser usado para separar componentes dentro de stacks.
// - SwiftUI gestiona el layout automáticamente, aprovechando todo el espacio disponible a menos que se especifique lo contrario.
