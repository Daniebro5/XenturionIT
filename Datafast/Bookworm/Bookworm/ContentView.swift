import SwiftData
import SwiftUI

struct ContentView: View {
  @Environment(\.modelContext) var modelContext
  @Query var books: [Book]

  @State private var showingAddScreen = false

  var body: some View {
    NavigationStack {
      Text("Cuenta: \(books.count)")
        .navigationTitle("Bookworm")
        .toolbar {
          Button("Add Book", systemImage: "plus") {
            showingAddScreen.toggle()
          }
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
