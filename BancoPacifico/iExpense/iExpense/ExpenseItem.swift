import Foundation

// si tengo un set limitado de opciones, debo usar enumeraciones
// String es un RawValue de esta enumeracion
enum ExpenseType: String, CaseIterable, Codable {
    case personal
    case empresarial
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}

final class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, 
                                                            from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
