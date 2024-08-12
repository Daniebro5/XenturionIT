import SwiftUI

struct ContentView: View {

    // cambios en las propiedades state, automaticamente reinvoca (redibuja) el body
    @State private var valorTotal = 0.0
    @State private var numeroDePersonas = 2
    @State private var propina = 20

    let propinas = [10, 15, 20, 25, 0]

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
            }

            Section {
                Text(valorTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
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
