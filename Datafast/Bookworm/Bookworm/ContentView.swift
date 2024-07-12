import SwiftData
import SwiftUI

struct ContentView: View {
  // interactuar con el almacenamiento local de nuestra app
  // los datos de la app se quedan guardados hasta eliminar la app
  // UserDefaults -> no es seguro, KeyChain
  @AppStorage("notes") private var notes = ""
  @Environment(\.modelContext) var modelContext
  @Query var students: [Student]

  var body: some View {
    NavigationStack {
      List(students) { student in
        Text(student.name)
      }
      .navigationTitle("Clase Omega")
      .toolbar {
        Button("Añadir") {
          let firstNames = ["Kevin", "Luis Alberto", "Enrique", "Luiggi", "Dario", "Andrea", "Hugo", "Luis Fernando"]
          let lastNames = ["Messi", "Ronaldo", "Potter", "Bucaram"]

          let nombreAleatorio = firstNames.randomElement()!
          let apellidoAleatorio = lastNames.randomElement()!

          let student = Student(id: UUID(), name: "\(nombreAleatorio) \(apellidoAleatorio)")

          modelContext.insert(student)
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
