import SwiftUI

struct ContentView: View {

    @State private var output = ""

    var body: some View {
        Text(output)
        // ejecuta codigo en otro hilo de ejecucion apenas aparezca la vista
            .task {
                // await quiere decir que la funcion llamada se encuentra en un contexto asincrono
                // el hilo principal siempre esta reservado para tareas de UI
                await fetchReadings()
            }
    }

    func fetchReadings() async {
        do {
            // Creamos la URL
            let url = URL(string: "https://hws.dev/readings.json")!
            // Obtenemos la data con el URLSession
            let (data, _) = try await URLSession.shared.data(from: url)
            // Decodificamos
            let readings = try JSONDecoder().decode([Double].self,
                                                    from: data)
            output = "He encontrado \(readings.count) lecturas"
        } catch {
            print("Error de descarga")
        }
    }
}

#Preview {
    ContentView()
}
