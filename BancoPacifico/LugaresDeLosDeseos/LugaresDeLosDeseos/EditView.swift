import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss

    var location: Location

    @State private var name: String
    @State private var description: String

    // patron de diseño delegacion
    var onSave: (Location) -> Void

    // escaping quiere decir que este closure pasado a la funcion no va a ser usado inmediatamente, va a ser guardado para ser usado despues (cuando el usuario toque en SAVE)
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place Name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    // no hay una regla en general de si es mejor crear un objeto desde cero
                    // o copiar uno existente y cambiar lo que queramos parte por parte como lo hacemos aquí, les animo a experimentar por uds mismos
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description

                    onSave(newLocation)

                    dismiss()
                }
            }
        }
    }
}

#Preview {
    EditView(location: Location.example, onSave: { _ in })
}
