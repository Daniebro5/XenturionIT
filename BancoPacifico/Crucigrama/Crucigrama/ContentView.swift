import SwiftUI

struct ContentView: View {
    // State es un property wrapper
    @State private var palabrasUsadas = [String]()
    // siempre que haya un cambio en una variable state
    // voy a redibujar la vista
    @State private var palabraRaiz = ""
    // la vista siempre tiene que reflejar el estado
    // de la aplicacion
    @State private var palabraNueva = ""

    @State private var errorTitulo = ""
    @State private var errorMensaje = ""
    @State private var estaMostrandoError = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Ingresa tu palabra",
                              text: $palabraNueva)
                    .textInputAutocapitalization(.never)
                }

                Section {
                    ForEach(palabrasUsadas,
                            id: \.self) { palabra in
                        // Stack horizontal
                        HStack {
                            Image(systemName: "\(palabra.count).circle")
                            Text(palabra)
                        }
                    }
                }
            }
            .navigationTitle(palabraRaiz)
            .onSubmit {
                addNewWord()
            }
            .onAppear(perform: startGame)
            .alert(errorTitulo, isPresented: $estaMostrandoError) {
                Button("OK") { }
            } message: {
                Text(errorMensaje)
            }
        }
    }

    func addNewWord() {
        // poner en minusculas y recortar la palabra, para estar seguros q no añado duplicados con diferencia en las mayusculas
        let respuesta = palabraNueva
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        // retornar rapido si la cadena esta vacia
        // aseguro que la respuesta no esté vacía
        guard !respuesta.isEmpty else {
            wordError(title: "Escribe algo primero",
                      message: "no funciona con cadenas vacias")
            return
        }

        guard respuesta != palabraRaiz else {
            wordError(title: "que lampara",
                      message: "chistosito estas no?")
            return
        }

        guard isOriginal(palabra: respuesta) else {
            wordError(title: "Palabra ya ha sido usada",
                      message: "tienes que ser mas original")
            return
        }

        guard isPossible(word: respuesta) else {
            wordError(title: "Palabra no es posible",
                      message: "No puedes formar esa palabra a partir de \(palabraRaiz)")
            return
        }

        guard isReal(word: respuesta) else {
            wordError(title: "Palabra no reconocida",
                      message: "No puedes solo crear palabras, tenemos diccionarios")
            return
        }

        guard esLarga(word: respuesta) else {
            wordError(title: "Palabra es muy corta",
                      message: "esfuerzate un poco más e incluye más letras en tu respuesta")
            return
        }

        // insert, inserta y los demas los mueve, es decir, no sobreescribe

        withAnimation {
            palabrasUsadas.insert(respuesta, at: 0)
        }

        palabraNueva = ""
    }

    func startGame() {
        // 1. encontramos la URL de mi archivo de inicio
        if let archivoInicialURL = Bundle.main.url(forResource: "start",
                                                   withExtension: "txt") {
            // 2. cargamos start.txt en una cadena
            if let palabrasIniciales = try? String(contentsOf: archivoInicialURL) {
                // 3. separamos la cadena en un array de cadenas, separando por saltos de linea
                let todasLasPalabras = palabrasIniciales.components(separatedBy: "\n")

                // 4. escogemos una palabra para q sea la Raiz o usamos "murcielago" como palabra por defecto
                palabraRaiz = todasLasPalabras.randomElement() ?? "murcielago"
                // si llegamos acá todo ha funcionado bien entonces puedo salir
                return
            }
        }

        // si llegamos acá, ocurrió un problema insalvable
        fatalError("No he podido encontrar start.txt en la aplicacion")
    }

    func isOriginal(palabra: String) -> Bool {
        !palabrasUsadas.contains(palabra)
    }

    func isPossible(word: String) -> Bool {
        var palabraTemporal = palabraRaiz

        for letra in word {
            if let pos = palabraTemporal.firstIndex(of: letra) {
                palabraTemporal.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let rangoMalEscrito = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en")
        return rangoMalEscrito.location == NSNotFound
    }

    func esLarga(word: String) -> Bool {
        return word.count > 3
    }

    func wordError(title: String, message: String) {
        errorTitulo = title
        errorMensaje = message
        estaMostrandoError = true
    }
}

#Preview {
    VStack {
        ContentView()
        ContentView()
        ContentView()
    }

}
