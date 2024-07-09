import Foundation
import UIKit

// MARK: - Colecciones: Arrays, Sets y Diccionarios

// Arrays: colección ordenada que puede contener elementos duplicados.
var nombres = ["Andrea", "Kevin", "Luis"]
nombres.append("Dario") // Agrega un nuevo elemento al final del array.

// Acceso a un elemento del array mediante su índice.
print("El cuarto nombre es: \(nombres[3])")

// Sets: colección no ordenada de elementos únicos.
var numerosUnicos = Set<Int>()
numerosUnicos.insert(5)
numerosUnicos.insert(5) // Los elementos repetidos no se añaden de nuevo.
print("Números únicos: \(numerosUnicos)")

// Diccionarios: colección de pares clave-valor.
var capitales = ["Ecuador": "Quito", "Francia": "París"]
capitales["Japón"] = "Tokio" // Agregar nuevo par clave-valor.
print("Capital de Ecuador: \(capitales["Ecuador"]!)") // Uso de ! para desempaquetado forzado.

// MARK: - Control de Flujo

// Bucle for-in para iterar sobre colecciones.
for nombre in nombres {
    print("Soy el mejor desarrollador y me llamo: \(nombre)")
}

// Bucle while que se ejecuta mientras se cumpla la condición.
var numero = 5
while numero > 0 {
    print(numero)
    numero -= 1 // Decremento para evitar un bucle infinito.
}

// Bucle repeat-while garantiza al menos una ejecución del código.
var contador = 10
repeat {
    print("Contador: \(contador)")
    contador += 1
} while contador <= 15

// Uso de break y continue en bucles.
let numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
for numero in numeros {
    if numero == 5 {
        break // Termina el bucle al encontrar el número 5.
    }
    if numero % 2 != 0 {
        continue // Salta los números impares.
    }
    print("Número par: \(numero)")
}

// MARK: - Funciones Avanzadas

// Funciones con múltiples parámetros.
func crearEmail(para destinatario: String, asunto: String, cuerpo: String) {
    print("Email enviado a \(destinatario) con asunto \(asunto) y cuerpo: \(cuerpo)")
}
crearEmail(para: "dario@ejemplo.com", asunto: "Promoción", cuerpo: "¡Felicidades, has sido promocionado!")

// Funciones con parámetros por defecto.
func enviarMemo(a destinatario: String = "Andrea", motivo: String = "por resabiada") {
    print("Memo enviado a \(destinatario) por: \(motivo)")
}
enviarMemo()
enviarMemo(a: "Enrique", motivo: "Grosero")

// Funciones variadicas aceptan un número indeterminado de parámetros.
func sumar(numeros: Int...) -> Int {
    return numeros.reduce(0, +)
}
print("La suma es \(sumar(numeros: 1, 2, 3, 4, 5))")

// Sobrecarga de funciones permite múltiples funciones con el mismo nombre pero diferentes parámetros.
func multiplicar(_ a: Double, _ b: Double) -> Double {
    return a * b
}
func multiplicar(_ a: Int, _ b: Int) -> Int {
    return a * b
}
print(multiplicar(5, 8))
print(multiplicar(5.61, 8.23))

// Funciones que devuelven múltiples valores usando tuplas.
func obtenerResultados() -> (golesArg: Int, golesEcu: Int) {
    return (3, 0)
}
let resultados = obtenerResultados()
print("El partido terminó \(resultados.golesArg)-\(resultados.golesEcu)")

// Funciones con parámetros inout permiten modificar los valores de los argumentos.
func intercambiar(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}
var primerNumero = 3
var segundoNumero = 107
intercambiar(&primerNumero, &segundoNumero)
print("Primer número ahora es \(primerNumero) y segundo número es \(segundoNumero)")
