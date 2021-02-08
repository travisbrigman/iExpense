//
//  ContentView.swift
//  iExpense
//
//  Created by Travis Brigman on 2/7/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import SwiftUI

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
