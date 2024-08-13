import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss

    var location: Location

    @State private var name: String
    @State private var description: String
    @State private var loadingState: LoadingState = .loading
    @State private var pages = [Page]()

    // patron de diseño delegacion
    var onSave: (Location) -> Void

    // escaping quiere decir que este closure pasado a la funcion no va a ser usado inmediatamente, va a ser guardado para ser usado despues (cuando el usuario toque en SAVE)
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place Name", text: $name)
                    TextField("Description", text: $description)
                }

                Section("Nearby...") {
                    switch loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(pages, id: \.pageId) { page in
                            Text(page.title)
                                .font(.headline)
                            // el signo + combina diferentes Text views para formar un text view mas grande con diferentes formatos
                            + Text(": ") +
                            Text("Page Description here")
                                .italic()
                        }
                    case .failed(let error):
                        Text("Error: ")
                            .font(.largeTitle)
                        + Text(error)
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    // no hay una regla en general de si es mejor crear un objeto desde cero
                    // o copiar uno existente y cambiar lo que queramos parte por parte como lo hacemos aquí, les animo a experimentar por uds mismos
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description

                    onSave(newLocation)

                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }

    enum LoadingState {
        case loading
        case loaded
        // valor asociado
        case failed(descripcion: String)
    }

    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        // desempaqueta y lo deja disponible en todo el alcance la funcion
        // sirve para chequear precondiciones y retornar rapido
        guard let url = URL(string: urlString) else {
            print("Bad url")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)

            pages = items.query.pages.values.sorted(by: { $0.title < $1.title })

            loadingState = .loaded
        } catch {
            loadingState = .failed(descripcion: error.localizedDescription)
        }
    }
}

#Preview {
    EditView(location: Location.example, onSave: { _ in })
}
