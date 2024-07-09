import SwiftUI

// Punto de entrada principal para la aplicación de estilo Instagram.
@main
struct DatafastConsumoAPIsAppApp: App {
    // El cuerpo de una estructura de App, define la configuración de la escena de la aplicación.
    var body: some Scene {
        // WindowGroup crea un grupo de ventanas para la interfaz de usuario.
        // Aquí es donde se define la vista raíz que se mostrará cuando se inicie la aplicación.
        WindowGroup {
            // InstagramFeedView es la vista principal que se muestra.
            // Esta vista contendrá el feed principal similar al de Instagram,
            // donde los usuarios pueden ver una lista de publicaciones.
            InstagramFeedView()
        }
    }
}
