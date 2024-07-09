import Foundation

/// Modelo para la respuesta del API que encapsula una lista de cócteles.
struct CocktailResponse: Codable {
    let drinks: [Cocktail]
}

/// Representa un cóctel. Conforma a `Codable` para facilitar la decodificación desde JSON
/// y a `Identifiable` para identificación única en SwiftUI Lists.
struct Cocktail: Codable, Identifiable {
    // 'id' es necesario para conformar a `Identifiable`. Especificamos el mapeo en `CodingKeys`.
    var id: String
    let nombre: String
    let urlImagen: String

    /// `CodingKeys` permite mapear las propiedades del struct a las claves específicas en el JSON.
    /// Útil cuando las claves del JSON no coinciden directamente con los nombres de las propiedades del modelo.
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"       // Mapea 'idDrink' del JSON a 'id' en Cocktail.
        case nombre = "strDrink"  // Mapea 'strDrink' a 'nombre'.
        case urlImagen = "strDrinkThumb"  // Mapea 'strDrinkThumb' a 'urlImagen'.
    }
}

// Extensión de `Cocktail` para incluir ejemplos estáticos usados en previews y testing.
extension Cocktail {
    /// Ejemplo estático de un cóctel para ser usado en vistas previas y pruebas.
    static let sangria: Self = .init(
        id: UUID().uuidString,  // Genera un UUID aleatorio para el ID.
        nombre: "Sangría",
        urlImagen: "https://www.thecocktaildb.com/images/media/drink/xxyywq1454511117.jpg"
    )
}
