import Foundation

// funcion especial para obtener los valores definidos en mi diccionario info
// este diccionario hereda de los configs, es decir que depende del contexto en donde sea ejecutado va a escribir los valores
enum Config {
    static func stringValue(forKey key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String  else { fatalError("Clave invalida o indefinida") }
        return value
    }
}
