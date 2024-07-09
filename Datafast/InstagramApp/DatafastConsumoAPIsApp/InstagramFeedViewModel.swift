import Combine
import Foundation

// Definición del modelo 'Story' que cumple con el protocolo 'Identifiable' para su uso en SwiftUI.
// Esto permite que 'Story' pueda ser identificado de manera única, facilitando su uso en listas y otras colecciones que requieran identidad.
struct Story: Identifiable {
    var id = UUID() // Identificador único para cada instancia.
    let image: String = "https://picsum.photos/200" // URL de una imagen de ejemplo.
    let nombreUsuario: String // Nombre del usuario asociado a la historia.
}

// ViewModel que se adhiere al patrón ObservableObject, permitiendo que las vistas observen sus cambios.
final class InstagramFeedViewModel: ObservableObject {
    @Published var stories = [Story]() // Colección de historias que será observada por la vista.

    // Constructor que inicializa el modelo de datos.
    init() {
        // Simulación de carga de datos con un retraso de 5 segundos.
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            for numero in 1...10 {
                // Cada historia se añade a la colección 'stories', disparando una actualización de la interfaz de usuario en SwiftUI.
                self.stories.append(Story(nombreUsuario: "Usuario \(numero)"))
            }
        }
    }
}

// Ejemplo conceptual del patrón publicador-suscriptor proporcionado por Combine.
// Este ejemplo ilustra cómo el ViewModel actúa como un publicador que emite actualizaciones que las vistas suscritas pueden observar.
// |-------S----------1------------2-----3-----4  <- Suscripciones y eventos a lo largo del tiempo
// |---------------1------------2-----3-----4--------X  <- Emisiones del publicador (datos actualizados)
// |------S----------1-------------2-----3-----4  <- Notificaciones a los suscriptores

// M-V-VM (Modelo-Vista-ViewModel) es un patrón de diseño de software que facilita la separación de la lógica de desarrollo de la interfaz de usuario de la lógica empresarial o de backend.
// - Modelo: Representa los datos y la lógica de negocio.
// - Vista: Código que maneja la visualización en la pantalla.
// - ViewModel: Abstrae y gestiona la relación entre el modelo y la vista, actuando como un intermediario que maneja la lógica de presentación.

