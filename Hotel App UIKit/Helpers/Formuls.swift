//
//  Formuls.swift
//  BankSimulator
//
//  Created by Анастасия on 29.12.2023.
//

import Foundation
import UIKit

final class Formuls {
    
    static let shared = Formuls()
    
    func intToCurrency(integer: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "P"
        formatter.currencyGroupingSeparator = " "
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: integer)) ?? String()
    }
    
    func phoneFormat(phoneNumber: String) -> String {
        var cleanPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        if cleanPhoneNumber.count > 1 {
            cleanPhoneNumber.removeFirst()
        }
           let mask = "(XXX) XXX-XX-XX"
           var result = "+7 "
           var cleanIndex = cleanPhoneNumber.startIndex
           var maskIndex = mask.startIndex

           while cleanIndex < cleanPhoneNumber.endIndex && maskIndex < mask.endIndex {
               if mask[maskIndex] == "X" {
                   result.append(cleanPhoneNumber[cleanIndex])
                   cleanIndex = cleanPhoneNumber.index(after: cleanIndex)
               } else {
                   result.append(mask[maskIndex])
               }
               maskIndex = mask.index(after: maskIndex)
           }
           return result
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
}
