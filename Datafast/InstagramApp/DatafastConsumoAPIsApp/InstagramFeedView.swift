import SwiftUI

struct InstagramFeedView: View {

  @ObservedObject var viewModel = InstagramFeedViewModel()

  // es la vista q se construye
  var body: some View {
    ScrollView {
      header
      carruselDeHistorias
      post
      post
    }
  }

  private var post: some View {
    VStack {
      HStack {
        AsyncImage(url: URL(string: "https://picsum.photos/200"))
          .scaledToFit()
          .frame(width: 28, height: 28)
          .clipShape(Circle())
        Text("nombre")
        Spacer()
        Image(systemName: Imagenes.elipsis.rawValue)
      }
      .padding(.top)
      .padding(.horizontal)
      AsyncImage(url: URL(string: "https://picsum.photos/400"))
      HStack {
        Image(systemName: Imagenes.corazon.rawValue)
        Image(systemName: Imagenes.iconoComentario.rawValue)
        Image(systemName: Imagenes.iconoEnviar.rawValue)
        Spacer()
        Image(systemName: Imagenes.iconoGuardar.rawValue)
      }
      .padding(.horizontal)
    }
  }

  private var tuHistoriaView: some View {
    VStack {
      ZStack {
        AsyncImage(url: URL(string: "https://picsum.photos/200"))
          .scaledToFit()
          .frame(width: 70, height: 70)
          .clipShape(Circle())
        VStack {
          Spacer()
          HStack {
            Spacer()
            Image(systemName: Imagenes.iconoMas.rawValue)
              .foregroundStyle(.white)
              .background(Color.blue)
              .clipShape(Circle())
              .padding(.trailing, 5)
              .padding(.bottom, 5)
          }
          .frame(maxWidth: 70)
        }
        .frame(maxHeight: 70)
      }
      Text("Tu Historia")
        .font(.caption2)
    }
    .padding(.leading, 4)
  }

  private var header: some View {
    HStack(spacing: 20) {
      Text("Instagram")
        .bold()
        .font(.title2)
      Image(systemName: Imagenes.chevronDown.rawValue)
      Spacer()
      Image(systemName: Imagenes.corazon.rawValue)
        .resizable()
        .frame(width: 22, height: 22)
      Image(Imagenes.iconoMessenger.rawValue)
        .resizable()
        .frame(width: 22, height: 22)
    }
    .padding(.horizontal, 16)
  }

  private var carruselDeHistorias: some View {
    HStack {
      tuHistoriaView

      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 10) {
          ForEach(viewModel.stories) { story in
            VStack {
              AsyncImage(url: URL(string: story.image))
                .scaledToFit()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
              Text(story.nombreUsuario)
                .font(.caption2)
            }
          }
        }
      }
    }
  }
}

#Preview {
  InstagramFeedView()
}

// A las enumeraciones podemos darle un "Valor crudo"
enum Imagenes: String {
  case iconoMessenger = "iconoMessenger"
  case chevronDown = "chevron.down"
  case corazon = "heart"
  case iconoPerfil = "brain.head.profile.fill"
  case iconoMas = "plus"
  case elipsis = "ellipsis"
  case iconoComentario = "message"
  case iconoEnviar = "paperplane"
  case iconoGuardar = "bookmark"
}

// la fuente de apple se llama SF PRO, SanFrancisco PRO

// scaled significa escalar manteniendo la forma
// scaledToFit crezco hasta topar alguna pared
// scaledToFill crezco hasta llenar el contenedor
