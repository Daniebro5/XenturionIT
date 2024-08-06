import Foundation

// si tengo un set limitado de opciones, debo usar enumeraciones
// String es un RawValue de esta enumeracion
enum ExpenseType: String, CaseIterable {
    case personal
    case empresarial
}

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]()
}
