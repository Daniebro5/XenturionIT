import SwiftUI

// La vista CocktailListView muestra una lista de cócteles utilizando una vista de navegación.
struct CocktailListView: View {
    // El viewModel gestiona los datos y la lógica de negocio relacionados con los cócteles.
    @StateObject var viewModel = CocktailViewModel()

    // El cuerpo define la interfaz de usuario de la vista.
    var body: some View {
        // NavigationView permite la navegación entre vistas, en este caso, a los detalles del cóctel.
        NavigationView {
            VStack {
                TextField("Buscar Cócteles", text: $viewModel.searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                List(viewModel.cocktails, id: \.id) { cocktail in
                    NavigationLink(destination: CocktailDetailView(cocktail: cocktail)) {
                        Text(cocktail.nombre)
                    }
                }
                .onAppear {
                    viewModel.fetchCocktails()
                }
            }
        }
    }
}

// PreviewProvider permite previsualizar la vista en el entorno de desarrollo.
struct CocktailListView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailListView()
    }
}
