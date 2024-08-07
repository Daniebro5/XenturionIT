import UIKit

// Arrays
print("=== ARRAYS ===")
var frutas: [String] = ["Manzana", "Banana", "Cereza"]

// caracteristicas
// 1. elementos ordenados
// 2. Duplicidad, sus elementos se pueden duplicar
// 3. Eficiencia

//      - busqueda por indice O(k), busqueda iterando O(n)
frutas[1] // [1] se lo llama subscript
frutas.firstIndex(of: "Manzana")

//      - insertar por indice O(k), insertar al final O(n)
frutas.insert("Aguacate", at: 1)
frutas.append("Kiwi")

//      - eliminacion por indice O(k), eliminacion iterando es O(n)
frutas.remove(at: 2)
frutas.removeAll { $0 == "Manzana" }



// Diccionarios
print("=== Diccionarios ===")

// caracteristicas
// 1. elementos NO ordenados
// 2. Claves Unicas, las claves son unicas pero los valores pueden ser duplicados
// 3. Eficiencia
//      - acceso por clave O(1)
//      - Insercion/actualizacion O(1)
//      - eliminacion O(1)

var capitales: [String: String] = [
    "Ecuador": "Quito",
    "Peru": "Lima",
    "Colombia": "Bogota"
]

capitales["Chile"] = "Santiago"
capitales["Peru"] = "Cusco"
capitales["PeruPremium"] = "Cusco"


// Funcion Hash
// no es reversible (no se puede obtener la clave a partir del hash)
// es facil de aplicar
// cierto nivel de confianza ante colisiones

// USA -> f(hash) -> hdagsytdeb29763 -> nil
// QATAR -> f(hash) -> hdagsytdeb29763 (colision con el hash de USA)

// es caotico (el minimo cambio en la clave, produce un hash completamente diferente)

// Ecuador -> f(hash) -> DKJSHDAKS123876 <- Quito
// ecuador -> f(hash) -> OAIUESHFNIOMHEF384279 <- Quito

capitales.removeValue(forKey: "Chile")
capitales["Chile"] = nil


// SETS
print("=== SETS ===")
// caracteristicas
// 1. elementos NO ordenados
// 2. no permite elementos duplicados
// 3. Eficiencia
//      - TODO es O(1)

var numeros: Set<Int> = [1,2,3,4,5] // la notacion <> significa el uso de genericos

numeros.insert(6)
numeros.insert(3) // busca la direccion de memoria y sobreescribe

// 3 -> f(hash) -> isufhniyoiwrycsoey123797 <- 1
// 3 -> f(hash) -> isufhniyoiwrycsoey123797 <- 1

numeros.remove(3)

// 3 -> f(hash) -> isufhniyoiwrycsoey123797 <- nil


// El set deberia ser mi primera opcion debido a su performance, si necesito algun tipo de relacion clave-valor, debo ir por un diccionario (Persona-Edad, Transaccion-Valor)
// si necesito guardar orden o tener duplicidad debo usar un array
