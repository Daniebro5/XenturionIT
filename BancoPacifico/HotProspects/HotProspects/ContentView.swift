import SwiftUI

struct ContentView: View {

    @State private var backgroundColor = Color.red

    var body: some View {
        // context menu recomendaciones:
        //  o no usarlo o usarlo en muchos lugares, porque si el usuario descubre uno, va a querer mantener presionado muchos otros elementos para descubir menus ocultos
        // mantengan la lista de opciones corta
        // no repitas opciones si ya la tienes en la app
        // no ocultes en context menus acciones importantes
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)

            Text("Change Color")
                .padding()
                .contextMenu {
                    Button("Red") {
                        backgroundColor = .red
                    }

                    Button("Green") {
                        backgroundColor = .green
                    }

                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
