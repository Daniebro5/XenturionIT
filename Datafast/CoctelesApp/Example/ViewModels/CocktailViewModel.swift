import Combine
import Foundation

/// `CocktailViewModel` maneja la lógica de negocio para buscar y mostrar cócteles.
/// Se marca como `final` para optimizar el tiempo de compilación evitando la herencia.
final class CocktailViewModel: ObservableObject {
    // Publica cambios en `searchText` y `cocktails` para que la vista pueda actualizarse en respuesta.
    @Published var searchText = ""
    @Published var cocktails = [Cocktail]()

    // Mantenimiento de las suscripciones Combine.
    private var cancellables: Set<AnyCancellable> = []

    /// Inicializa el ViewModel, configurando la suscripción a cambios en `searchText`.
    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main) // Reduce la carga de trabajo al minimizar las búsquedas frecuentes.
            .removeDuplicates() // Evita búsquedas repetitivas con el mismo texto.
            .sink { [weak self] searchText in
                guard let self = self else { return }
                self.fetchCocktail(query: searchText) // Busca cócteles según el texto de búsqueda.
            }
            .store(in: &cancellables)
    }

    /// Realiza la búsqueda de cócteles basada en un texto de consulta.
    func fetchCocktail(query: String) {
        Task {
            do {
                let cocktails = try await loadCocktails(query: query)
                // Actualiza la UI en el hilo principal.
                DispatchQueue.main.async {
                    self.cocktails = cocktails
                }
            } catch {
                print("Error fetching cocktails: \(error)")
                DispatchQueue.main.async {
                    self.cocktails = [] // Presenta una lista vacía en caso de error.
                }
            }
        }
    }

    /// Carga los cócteles de forma asincrónica utilizando `async/await`.
    private func loadCocktails(query: String) async throws -> [Cocktail] {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(query)") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(CocktailResponse.self, from: data)
        return decodedResponse.drinks
    }

    /// Obtiene cócteles alcohólicos utilizando `Combine` para trabajar con flujos de datos.
    func fetchCocktails() {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic") else {
            return // Finaliza temprano si la URL no es válida.
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CocktailResponse.self, decoder: JSONDecoder())
            .map { $0.drinks }
            .replaceError(with: []) // Utiliza un array vacío en caso de error.
            .receive(on: DispatchQueue.main) // Asegura que la UI se actualice en el hilo principal.
            .assign(to: &$cocktails) // Actualiza `cocktails` con los resultados.
    }
}
