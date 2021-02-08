//
//  ContentView.swift
//  iExpense
//
//  Created by Travis Brigman on 2/7/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import SwiftUI


class Expenses: ObservableObject {
    @Published var items = [ExpenseItem](){
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
            
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items ) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct AmountColor: ViewModifier {
    var expenseAmount: Int
    
    func body(content: Content) -> some View {
            switch expenseAmount {
            case 0...10:
            return content.foregroundColor(.black)
            case  11...100 :
           return content.foregroundColor(.green)
            default: return content.foregroundColor(.red)
        }
    }

}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(expenses.items) {
                    item in HStack {
                        VStack {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                            .modifier(AmountColor(expenseAmount: item.amount))
                    }
                }
                .onDelete(perform: removeItems)
            }
                
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton() ,trailing: Button( action: { self.showingAddExpense = true
            }){
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
