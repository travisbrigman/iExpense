//
//  ViewModifier.swift
//  iExpense
//
//  Created by Travis Brigman on 2/8/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import SwiftUI

public struct AmountColor: ViewModifier {
    var expenseAmount: Int
    
    public func body(content: Content) -> some View {
        switch expenseAmount {
            case 0...10:
                return content.foregroundColor(.black)
            case  11...100 :
                return content.foregroundColor(.green)
            default:
                return content.foregroundColor(.red)
        }
    }
}
