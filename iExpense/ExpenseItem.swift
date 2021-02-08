//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Travis Brigman on 2/7/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import Foundation

public struct ExpenseItem: Identifiable, Codable {
    public let id = UUID()
    let name: String
    let type: String
    let amount: Int
    
}
