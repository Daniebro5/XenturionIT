import SwiftUI

struct ContentView: View {

    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()

    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}

#Preview {
    ContentView()
}

struct User: Identifiable, Comparable {
    let id = UUID()
    var firstName: String
    var lastName: String

    // Sobrecarga de operadores
    // left-right hand side (user1) < (user2)
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }

    // comparable tambien nos da el operador >, solo hace flip del booleano del operador <
}
