//
//  Utils.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/27/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import Foundation


func convertToCurrency(_ number: Double) -> String {
       
       let currencyFormatter = NumberFormatter()
       currencyFormatter.usesGroupingSeparator = true
       currencyFormatter.numberStyle = .currency
       currencyFormatter.locale = Locale.current
       
       return currencyFormatter.string(from: NSNumber(value: number))!
}
