import SwiftUI

struct AddBookView: View {

  @Environment(\.dismiss) var dismiss
  @Environment(\.modelContext) var modelContext

  @State private var titulo = ""
  @State private var autor = ""
  @State private var genero = "Novela"
  @State private var review = ""
  @State private var rating = 3

  let generos = ["Fantasia", "Horror", "Infantil", "Misterio", "Romance", "Comedia", "Novela"]

  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("Nombre del libro", text: $titulo)
          TextField("Autor del libro", text: $autor)
          Picker("Genero", selection: $genero) {
            ForEach(generos, id: \.self) {
              Text($0)
            }
          }
        }

        Section("Escribe la review") {
          TextEditor(text: $review)

          RatingView(rating: $rating)
        }

        Section {
          Button("Guardar") {
            let nuevoLibro = Book(titulo: titulo,
                                  autor: autor,
                                  genero: genero,
                                  review: review,
                                  rating: rating)
            modelContext.insert(nuevoLibro)
            dismiss()
          }
        }
      }
      .navigationTitle("Añadir libro")
    }
  }
}

#Preview {
  AddBookView()
}
