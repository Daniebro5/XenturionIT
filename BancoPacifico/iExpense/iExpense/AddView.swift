import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type: ExpenseType = .personal
    @State private var amount = 0.0

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
        }
    }
}

#Preview {
    AddView()
}
