import SwiftUI

enum ErroresDeRed: Error {
    case adsdasd, cas, casca, casgh

    static func analytics() {
        // llamar a mi servidor de analytics
    }
}

enum RedReultado {
    case completado
    case error(error: String)
}

final class ClaseConFuga {
    var handler: (() -> Void)?
    let value: Int

    init(value: Int) {
        self.value = value
        // capture list
        handler = { [weak self] in
            guard let self else {
                // llamaria a mi analytics para resolver alguna fuga
                return
            }
            self.hacerAlgo()
        }
    }

    func hacerAlgo() {
        print("Haciendo algo")
    }

    deinit {
        print("Clase con fuga fue deinicializada")
    }
}

struct ContentView: View {

    @State private var estaMostrandoDetalles = false

    var body: some View {
        VStack {
            Button("Ir al detalle") {
                estaMostrandoDetalles = true
            }
            .sheet(isPresented: $estaMostrandoDetalles) {
                DetailView(claseConFuga: ClaseConFuga(value: Int.random(in: 0 ... 10000)))
            }
        }
        .padding()
    }
}

struct DetailView: View {
    let claseConFuga: ClaseConFuga

    var body: some View {
        Text("Vista de detalle: \(claseConFuga.value)")
            .onDisappear(perform: claseConFuga.handler)
    }
}

#Preview {
    ContentView()
}
