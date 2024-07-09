import SwiftUI

// Vista principal que simula un feed de Instagram.
struct InstagramFeedView: View {
    @ObservedObject var viewModel = InstagramFeedViewModel()

    // La vista principal que se construye con un ScrollView.
    var body: some View {
        ScrollView {
            header
            carruselDeHistorias
            post
            post
        }
    }

    // Vista que representa la cabecera del feed, similar a la barra superior de Instagram.
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

    // Vista que muestra el carrusel de historias, incluyendo la propia del usuario.
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

    // Vista que muestra una historia de usuario personalizada para el perfil "Tu Historia".
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
                            .padding(5)
                    }
                    .frame(width: 70, height: 70)
                }
            }
            Text("Tu Historia")
                .font(.caption2)
        }
        .padding(.leading, 4)
    }

    // Vista que representa una publicación individual dentro del feed.
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
            .padding(.horizontal)
            .padding(.top)
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
}

// Enumeración para gestionar las imágenes usadas en la interfaz, usando raw values para simplificar el manejo.
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

// Preview que permite visualizar la interfaz diseñada en el canvas de Xcode.
struct InstagramFeedView_Previews: PreviewProvider {
    static var previews: some View {
        InstagramFeedView()
    }
}
