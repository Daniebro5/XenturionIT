import SwiftData
import SwiftUI

struct DetailView: View {

  let book: Book

  var body: some View {
    ScrollView {
      ZStack(alignment: .bottomTrailing) {
        Image(systemName: "books.vertical")
          .resizable()
          .scaledToFit()

        Text(book.genero.uppercased())
          .font(.caption)
          .fontWeight(.black)
          .padding(8)
          .foregroundStyle(.white)
          .background(.cyan.opacity(0.75))
          .clipShape(.capsule)
          .offset(x: -5, y: -5)
      }

      Text(book.autor)
        .font(.title)
        .foregroundStyle(.secondary)

      Text(book.review)
        .padding()

      RatingView(rating: .constant(book.rating))
        .font(.largeTitle)
    }
    .navigationTitle(book.titulo)
    .navigationBarTitleDisplayMode(.inline)
    .scrollBounceBehavior(.basedOnSize)
  }
}

#Preview {
  do {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: Book.self, 
                                       configurations: config)
    let example = Book(titulo: "Prueba",
                       autor: "Autor de Prueba",
                       genero: "Fantasia",
                       review: "Es un libro de prueba para usar en las previews",
                       rating: 4)
    return DetailView(book: example)
      .modelContainer(container)
  } catch {
    return Text("falla en obtener la preview: \(error.localizedDescription)")
  }
}
