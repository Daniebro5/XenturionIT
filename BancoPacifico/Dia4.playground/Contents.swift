import UIKit

// ***** CLOSURES *****

// () -> ()
func saludar() {
    print("hi there")
}

saludar()

var saludarCopia = saludar
saludarCopia()

// type signature - firma de tipo
// todos los typos en Swift tienen una firma de tipo asociada, y se las trata como tuplas, incluidas las funciones

var numero = 5 // Tupla (Int)
var cadena = "cadena" // Tupla (String)

var otroNumero = 10 // (Int)
otroNumero = numero

// (Int, Int) -> (Int)
func sumar(entero1: Int, entero2: Int) -> Int {
    return entero1 + entero2
}


var suma = sumar(entero1: 4, entero2: 6)

// CLOSURE
let decirHola = { (name: String) -> String in
    "Hola \(name)"
}

// FUNCION
func decirHola2(name: String) -> String {
    return "Hola \(name)"
}


func getUserData(for id: Int) -> String {
    if id == 1234 {
        return "Danni"
    } else {
        return "anonimo"
    }
}

let data: (Int) -> String = getUserData
let user = data(1234)
let user2 = getUserData(for: 1234)
print(user)

let team = ["Barcelona", "Emelec", "Liga de Quito", "Mushuc Runa", "Bonita Banana"]
let sortedTeam = team.sorted()

// (String, String) -> Bool
func ligaPrimeroSort(equipo1: String, equipo2: String) -> Bool {
    if equipo1 == "Liga de Quito" {
        return true
    } else if equipo2 == "Liga de Quito" {
        return false
    }

    return equipo1 < equipo2
}

let closure = ligaPrimeroSort

let ligaPrimero = team.sorted(by: closure)
print(ligaPrimero)

// Trailing clousure
let ligaPrimero2 = team.sorted { equipo1, equipo2 in
    if equipo1 == "Liga de Quito" {
        return true
    } else if equipo2 == "Liga de Quito" {
        return false
    }

    return equipo1 < equipo2
}


// Trailing Closure y Shorthand Syntax


let tragos = ["Pilsener", "Jhonny Rojo", "Norteño", "Pecho Suko", "Canta Claro", "Pajaro Azul"]

// sintaxis trailing closure
// (String, String) -> Bool
let pilsenerPrimera = tragos.sorted { (trago1: String, trago2: String) -> Bool in
    if trago1 == "Norteño" {
        return true
    } else if trago2 == "Norteño" {
        return false
    }

    return trago1 < trago2
}

// Shorthand Syntax
// ($0: String, $1: String) -> Bool
let pilsenerPrimera2 = tragos.sorted {
    if $0 == "Norteño" {
        return true
    } else if $1 == "Norteño" {
        return false
    }

    return $0 < $1
}



let ordenadoNormal = tragos.sorted { trago1, trago2 in
    return trago1 < trago2
}

// usamos variables anonimas xq ya conocemos la firma del closure
let ordenadoCorto1 = tragos.sorted {
    return $0 < $1
}

// swift es lo suficientemente inteligente para saber que si solo hay una linea de codigo, debe pertenecer al return
let ordenadoCorto2 = tragos.sorted {
    $0 < $1
}

// Eliminamos los saltos de linea innecesarios xq no hay mas codigo
// Shorthand Syntax
let ordenadoCorto3 = tragos.sorted { $0 < $1 }



// (T) -> (To)
let mayusculasTragos = tragos.map { $0.uppercased() }
print(mayusculasTragos)
