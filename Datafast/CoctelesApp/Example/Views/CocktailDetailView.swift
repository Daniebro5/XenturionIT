import SwiftUI

struct CocktailDetailView: View {
    let cocktail: Cocktail

    var body: some View {
        ScrollView {
            Text("Esta es mi lista de detalle 😎")
                .kerning(20)
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)
                .background(Color.white)
            Text(cocktail.nombre)
                .font(.largeTitle)
                .foregroundStyle(.red)
                .background(Color.blue)
                .padding(.bottom, 50)
            AsyncImage(url: URL(string: cocktail.urlImagen)!)
                .blur(radius: 15)
        }
        .background(Color.cyan)
    }
}

#Preview {
    CocktailDetailView(cocktail: Cocktail.sangria)
}
