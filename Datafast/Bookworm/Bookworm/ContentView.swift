import SwiftData
import SwiftUI

struct ContentView: View {
  @Environment(\.modelContext) var modelContext
  @Query var books: [Book]

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
      }
      .navigationTitle("Bookworm")
      .toolbar {
        Button("Add Book", systemImage: "plus") {
          showingAddScreen.toggle()
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
}

#Preview {
  ContentView()
}
