//
//  Expenses.swift
//  iExpense
//
//  Created by Travis Brigman on 2/8/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import Foundation

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
