import Combine
import SwiftUI
import Foundation

struct CocktailResponse: Codable {
    let drinks: [Cocktail]
}

// Codable es un protocolo que nos ayuda a serializar (entre ellos en el formato JSON)
// Identifiable es un protocolo que nos permite diferenciar una instancia de otra
struct Cocktail: Codable, Identifiable {
    var id: String
    let nombre: String
    let urlImagen: String

    // si los nombres que recibimos desde el API son los mismos que vamnos a usar localmente
    // podemos saltarnos esta parte de las CodingKeys
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case nombre = "strDrink"
        case urlImagen = "strDrinkThumb"
    }
}

extension Cocktail {
    static let sangria: Self = .init(
        id: UUID().uuidString,
        nombre: "Sangría",
        urlImagen: "https://www.thecocktaildb.com/images/media/drink/xxyywq1454511117.jpg"
    )
}
