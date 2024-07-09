// patron de diseño observador
import Combine
import Foundation

// el protocolo Identifiable
struct Story: Identifiable {
  var id = UUID()

  let image = "https://picsum.photos/200"
  let nombreUsuario: String
}

final class InstagramFeedViewModel: ObservableObject {
  @Published var stories = [Story]()

  init() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
      for numero in 1 ... 10 {
        self.stories.append(Story(nombreUsuario: "Usuario \(numero)"))
      }
    }
  }
}

// publicadores/observables
// suscriptores

// Estadio Publicador/Observable (Que se puede observar)




// Hugo se suscribe a la revista estadio
// Enrique tambien
// Publicador publica la revista y cada uno de los suscriptores
// recibve una copia



// |-------S----------1------------2-----3-----4
//         /\        /            /     /     /
//          |       /            /     /     /
// |---------------1------------2-----3-----4--------X Revista estadio
//        |         \            \     \     \
//        v          v            v     v     v
// |------S----------1-------------2-----3-----4

// La vista debe reflejar el estado del ViewModel



// M-V-VM
// modelo - vista - viewModel
