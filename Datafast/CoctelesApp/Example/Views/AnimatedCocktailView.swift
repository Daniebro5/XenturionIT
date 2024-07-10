import SwiftUI

struct AnimatedCocktailView: View {
  @State private var scale: CGFloat = 1.0
  @State private var opacity: Double = 1.0
  @State private var angle: Double = 0
  @State private var searchText = ""
  @State private var isShowingDetails = false

  var body: some View {
    NavigationView {
      VStack {
        TextField("Buscar Cocteles",
                  text: $searchText)
        .padding()
        .background(Color.gray.opacity(opacity))
        .cornerRadius(20)
        .padding()
        .overlay {
          RoundedRectangle(cornerRadius: 25.0)
            .stroke(Color.blue, lineWidth: 3)
            .scaleEffect(scale)
            .opacity(opacity)
            .animation(.easeIn(duration: 0.5), value: searchText)
        }

        Image(systemName: "lasso.badge.sparkles")
          .resizable()
          .scaledToFit()
          .frame(width: 100, height: 100)
          .rotationEffect(.degrees(angle))
          .scaleEffect(scale)
          .opacity(opacity)
          .onTapGesture {
            withAnimation(.bouncy) {
              angle += 720
              scale = scale == 1.0 ? 1.5 : 1.0
              opacity = opacity == 1.0 ? 0.5 : 1.0
            }
          }
        Button(isShowingDetails ? "ocultar detalles" : "mostrar detalles") {
          withAnimation(.easeInOut(duration: 3)) {
            isShowingDetails.toggle()
          }
        }

        if isShowingDetails {
          Text("Mas detalles acerca del curso aqui")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.purple.opacity(opacity))
            .transition(.slide)
        }
        Spacer()
      }
      .navigationTitle("Animando texto e imagenes")
    }
  }
}

#Preview {
  AnimatedCocktailView()
}
