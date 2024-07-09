import Combine
import Foundation

// final hace que una clase no se pueda heredar
// cuando nuestra app va creciendo, el numero de clases va aumentando
// el compilador va a tener que chequear que cada clase hija, herede bien de sus padres
// con final hacemos que el compilador se salte estos chequeos y simplemente nos de error
final class CocktailViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var cocktails = [Cocktail]()

    private var cancellables: Set<AnyCancellable> = []

    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates() // hola holas hola holas hola
            .sink { [weak self] searchText in
                guard let self else { return }
                self.fetchCocktail(query: searchText)
            }
            .store(in: &cancellables)
    }


    func fetchCocktail(query: String) {
        // es el puente entre lo serial y concurrente
        // task envia lo de adentro hacia un hilo en background
        Task {
            do {
                let cocteles = try await loadCocktails(query: query)
                DispatchQueue.main.async {
                    self.cocktails = cocteles
                }
            } catch {
                print("Error fetching cocktails \(error)")
                self.cocktails = []
            }
        }
    }

    // nuevo enfoque para llamadas usando async/await
    private func loadCocktails(query: String) async throws -> [Cocktail] {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(query)") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(CocktailResponse.self, from: data)
        return decodedResponse.drinks
    }

//    @MainActor - ahora se usan Actors para controlan concurrencia
    func fetchCocktails() {
        // obteniendo la url para los cocteles alcoholicos
        // hacemos un safe unwrap xq URL() nos devuelve un opcional
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic") else {
            return
        }

        // Session de networking que se ejecuta en paralelo
        // por defect usamos HTTPS y GET
        URLSession.shared.dataTaskPublisher(for: url)
        // mapeamos para obtener la data de la respuesta (objeto JSON)
            .map { $0.data }
        // usamos los modelos con CODABLE para deserializar el JSON
            .decode(type: CocktailResponse.self, decoder: JSONDecoder())
        // mapeamos la respuesta y obtenemos el valor de la clave drinks
            .map { $0.drinks }
        // sustituimos cualquier error con un array vacío
            .replaceError(with: [])
        // depues de hacer la llamada volvemos al hilo principal
            .receive(on: DispatchQueue.main)
        // asignamos los datos a la variable cocktails
            .assign(to: &$cocktails)
    }
}

// todo lo que tenga que ver con interfaz gráfica va a ser ejecutado en el hilo principal
// para que no existan trabas, errores de congelamiento, etc para el usuario
