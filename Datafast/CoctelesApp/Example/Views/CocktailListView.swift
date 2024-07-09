import SwiftUI

// La vista CocktailListView muestra una lista de cócteles utilizando una vista de navegación.
struct CocktailListView: View {
    // El viewModel gestiona los datos y la lógica de negocio relacionados con los cócteles.
    @StateObject var viewModel = CocktailViewModel()

    // El cuerpo define la interfaz de usuario de la vista.
    var body: some View {
        // NavigationView permite la navegación entre vistas, en este caso, a los detalles del cóctel.
        NavigationView {
            // List genera una lista de elementos extraídos del array 'cocktails' en el viewModel.
            List(viewModel.cocktails, id: \.id) { cocktail in
                // NavigationLink crea un enlace que, cuando se toca, lleva al usuario a la vista de detalle del cóctel seleccionado.
                NavigationLink(destination: CocktailDetailView(cocktail: cocktail)) {
                    // Cada elemento de la lista muestra el nombre del cóctel.
                    Text(cocktail.nombre)
                }
            }
            // onAppear se dispara cuando la vista aparece en pantalla.
            .onAppear {
                // Llama a fetchCocktails para cargar los datos de los cócteles.
                viewModel.fetchCocktails()
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
