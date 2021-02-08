//
//  AddView.swift
//  iExpense
//
//  Created by Travis Brigman on 2/8/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "personal"
    @State private var amount = ""
    static let types = ["Business", "Personal"]
    
    //🚨🚨🚨Alert Message Stuff 🚨🚨🚨
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount, onCommit: textValidation)
                    .keyboardType(.numberPad)
            }
                
            .navigationBarTitle("Add New Expense")
            .navigationBarItems(trailing: Button("Save"){
                self.textValidation()
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
        .alert(isPresented: $showingError){
            .init(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func textValidation() {
        guard Int(amount) != nil else {
            errorTitle = "Whoops"
            errorMessage = "that's not a expense amount!"
            return showingError.toggle()
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
