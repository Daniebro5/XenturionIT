import SwiftUI

struct CocktailListView: View {
    @StateObject var viewModel = CocktailViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.cocktails, id: \.id) { cocktail in
                NavigationLink(destination: CocktailDetailView(cocktail: cocktail)) { Text(cocktail.nombre) }
            }
            .onAppear {
                viewModel.fetchCocktails()
            }
        }
    }
}

#Preview {
    CocktailListView()
}
