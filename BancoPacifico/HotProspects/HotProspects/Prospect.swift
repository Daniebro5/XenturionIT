import SwiftData

// final hace que una clase no se pueda heredar
// el compilador no hará cross-check de herencia, sobrecarga ni polimorfismo
// el build time no se aumentará tanto
@Model
final class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool

    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}
