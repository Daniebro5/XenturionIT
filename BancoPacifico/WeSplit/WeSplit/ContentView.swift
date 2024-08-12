import SwiftUI

struct ContentView: View {

    // cambios en las propiedades state, automaticamente reinvoca (redibuja) el body
    @State private var valorTotal = 0.0
    @State private var numeroDePersonas = 2
    @State private var propina = 20

    let propinas = [10, 15, 20, 25, 0]

    // propiedad computada para el valor total
    // usemos propiedades computadas, ya que estas se integran bastante bien con el redibujado de las vistas en swiftUI
    var totalPorPersona: Double {
        let cantidadDePersonas = Double(numeroDePersonas + 2)
        let seleccionPropina = Double(propina)

        let valorPropina = valorTotal / 100.0 * seleccionPropina
        let granTotal = valorTotal + valorPropina
        let valorPorPersona = granTotal / cantidadDePersonas

        return valorPorPersona
    }

    var body: some View {
        Form {
            Section {
                // placeholder
                TextField("Valor de la cuenta",
                          // two way binding
                          value: $valorTotal,
                          // controla el formato de ingreso
                          format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                )
                .keyboardType(.decimalPad)

                Picker("Numero de Personas",
                       selection: $numeroDePersonas) {
                    ForEach(2 ..< 100) {
                        Text("\($0) personas")
                    }

                    // valor    2-3-4-5-......
                    // posicion 0-1-2-3-4-5-6-
                }
            }

            Section {
                Text("Cuanta propina deseas dejar?")
                Picker("Porcentaje de propina",
                       selection: $propina) {
                    ForEach(propinas, id: \.self) {
                        Text($0, format: .percent)
                    }
                }
                // usaremos este picker con selecciones cortas y una lista pequeña
                       .pickerStyle(.segmented)
            }

            Section {
                Text(totalPorPersona, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            }
        }
    }
}

#Preview("Light") {
    ContentView()
        .preferredColorScheme(.light)
}

#Preview("dark") {
    ContentView()
        .preferredColorScheme(.dark)
}

// LOCALE
// concepto que se refiere a propiedades culturales de la region en la que se ejecuta la app
// argentina -  Peso Argentino - izq/der - yyyy/dd/mm - 1,000
// usa          USD - izq/der - mm/dd/yyyy - 1.000
