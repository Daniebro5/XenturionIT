import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type: ExpenseType = .personal
    @State private var amount = 0.0

    var expenses: Expenses

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
