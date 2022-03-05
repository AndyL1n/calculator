//
//  CaculateModel.swift
//  CaculateCore
//
//  Created by Andy on 2022/3/5.
//

import Foundation
import UIKit

public enum CalculatorButtonType: Int {
    case Number0    // "0"
    case Number1    // "1"
    case Number2    // "2"
    case Number3    // "3"
    case Number4    // "4"
    case Number5    // "5"
    case Number6    // "6"
    case Number7    // "7"
    case Number8    // "8"
    case Number9    // "9"
    
    case Plus       // "+"
    case Minus      // "-"
    case Multiply   // "*"
    case Divide     // "/"
    case Calculate  // "="
    case AC         // "AC"
    case Dot        // "."
    
    case Factorial  // "！"
    
    public var symbol: String {
        switch self {
        case .Number0:      return "0"
        case .Number1:      return "1"
        case .Number2:      return "2"
        case .Number3:      return "3"
        case .Number4:      return "4"
        case .Number5:      return "5"
        case .Number6:      return "6"
        case .Number7:      return "7"
        case .Number8:      return "8"
        case .Number9:      return "9"

        case .Plus:         return "+"
        case .Minus:        return "-"
        case .Multiply:     return "×"
        case .Divide:       return "÷"
        case .Calculate:    return "="
        case .AC:           return "AC"
        case .Dot:          return "."
            
        case .Factorial:    return "！"
        }
    }
    
    public var backgroundColor: UIColor {
        switch self {
        case .Plus, .Minus, .Multiply, .Divide, .Calculate, .AC, .Factorial:
            return .orange
        default:
            return .gray
        }

    }
}
