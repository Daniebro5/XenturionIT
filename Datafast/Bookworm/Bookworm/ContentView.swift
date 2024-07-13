import SwiftData
import SwiftUI

struct ContentView: View {
  @Environment(\.modelContext) var modelContext
  @Query(sort: [
    SortDescriptor(\Book.rating, order: .reverse),
    SortDescriptor(\Book.autor),
  ]) var books: [Book]

  @State private var showingAddScreen = false

  var body: some View {
    NavigationStack {
      List {
        ForEach(books) { book in
          NavigationLink(value: book) {
            HStack {
              EmojiRatingView(rating: book.rating)
                .font(.largeTitle)

              VStack(alignment: .leading) {
                Text(book.titulo)
                  .font(.headline)
                Text(book.autor)
                  .foregroundStyle(.secondary)
              }
            }
          }
        }
        .onDelete(perform: deleteBooks)
      }
      .navigationTitle("Bookworm")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Add Book", systemImage: "plus") {
            showingAddScreen.toggle()
          }
        }
        ToolbarItem(placement: .topBarLeading) {
          EditButton()
        }
      }
      .navigationDestination(for: Book.self) { book in
        DetailView(book: book)
      }
    }
    .sheet(isPresented: $showingAddScreen) {
      AddBookView()
    }
  }

  func deleteBooks(at offsets: IndexSet) {
    for offset in offsets {
      // encontramos el libro en el query
      let book = books[offset]

      // eliminamos el libro del contexto
      modelContext.delete(book)
    }
  }
}

#Preview {
  ContentView()
}
