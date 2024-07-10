import SwiftUI

// Define el punto de entrada de la aplicación SwiftUI.
@main
struct ExampleApp: App {
    // El cuerpo de una estructura 'App' define la configuración de la escena principal de la aplicación.
    var body: some Scene {
        // WindowGroup es un contenedor para una interfaz de usuario que maneja la presentación
        // de una o más ventanas en un entorno de aplicación basada en SwiftUI.
        WindowGroup {
            // CocktailListView es la vista raíz que se muestra al iniciar la aplicación.
            // Desde aquí, los usuarios pueden comenzar su interacción con la funcionalidad de la aplicación.
            AnimatedCocktailView()
        }
    }
}
