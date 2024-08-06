import SwiftUI

struct ContentView: View {

    @State private var expenses = Expenses()

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items, id: \.name) { item in
                    Text(item.name)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    let expense = ExpenseItem(
                        name: "Prueba",
                        type: "Personal",
                        amount: 23)
                    expenses.items.append(expense)
                }
            }
        }
    }
}

#Preview("ContentView") {
    ContentView()
}
