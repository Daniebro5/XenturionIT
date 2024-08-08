import SwiftUI

struct ContentView: View {

    // botones del toolbar en iOS serán colocados en la parte derecha del NavigationBar para lenguajes que se leen de izq-der como el español e inglés

    // en iOS leading, significa izquierda en lenguajes que se leen de izq a der

    // en iOS trailing, significa derecha en lenguajes que se leen de izq a der

    // posiciones semanticas

    // confirmationAction - cuando el user quiere confirmar unos terminos de servicio por ejemplo
    // destructive action - cuando el usuario ha elegido destruir lo que sea con lo que esté trabajando, por ejemplo una transaccion que ya no la quiere hacer
    // cancellationAction - cuando el usuario quiere volver a un estado anterior a sus cambios, por ejemplo ha cambiado el nombre a uno de sus contactos y se arrepiente
    // navigation el cual es usado cuando el usuario se mueve entre pantallas

    // TIP si queremos que el usuario decida guardar o cancelar un cambio podemos ocultar el navigationBar

    var body: some View {
        NavigationStack {
            Text("Hello World")
                .toolbar {
                    ToolbarItemGroup(placement: .confirmationAction) {
                        Button("Tap Me") {
                            //
                        }
                        Button("Or Tap Me") {
                            //
                        }
                    }
                }
        }
    }

}

#Preview {
    ContentView()
}
