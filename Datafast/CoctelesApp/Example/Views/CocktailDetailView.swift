import SwiftUI

// La vista CocktailDetailView muestra los detalles específicos de un cóctel.
struct CocktailDetailView: View {
    let cocktail: Cocktail // Propiedad que almacena la información del cóctel seleccionado.

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Text("Esta es mi lista de detalle 😎")
                    .kerning(20) // Espaciado entre caracteres.
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 50)
                    .background(Color.white)

                Text(cocktail.nombre)
                    .font(.largeTitle) // Tamaño de fuente grande para el título.
                    .foregroundStyle(.red)
                    .background(Color.blue)
                    .padding(.bottom, 50)

                // Imagen del cóctel. El uso de 'URL(string:)' implica que se podría causar un crash si la URL es inválida.
                // Se recomienda manejar mejor este posible nil usando un enlace opcional y un placeholder en caso de error.
                if let url = URL(string: cocktail.urlImagen) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Text("Cargando imagen...")
                            .foregroundColor(.gray)
                    }
                    .blur(radius: 15) // Aplica un desenfoque para un efecto estético.
                    .padding(.bottom, 50)
                } else {
                    Text("Imagen no disponible")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.cyan)
        }
    }
}

// Implementación del PreviewProvider para visualizar la vista en el canvas de desarrollo.
struct CocktailDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Asegúrate de que el objeto Cocktail está correctamente inicializado aquí.
        CocktailDetailView(cocktail: Cocktail(id: UUID().uuidString, nombre: "Sangría", urlImagen: "https://picsum.photos/400"))
    }
}
