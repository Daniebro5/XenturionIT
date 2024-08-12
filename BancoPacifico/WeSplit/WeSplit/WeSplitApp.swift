import SwiftUI

@main
struct WeSplitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// si queremos que algo viva por todo el ciclo de la app, debemos ponerlo aquí
// por ejemplo analytics, o registrar la app para notificaciones
// aqui chequeriamos si existe una sesion del usuario, la capa de networking debe tener aditivos como para manejar el bearer token si este es usado.
