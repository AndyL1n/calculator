//
//  Double+extension.swift
//  main_2022
//
//  Created by Andy on 2022/3/2.
//

import Foundation

extension Double {
    public func decimalString(digit: Int = 0) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = digit
        return formatter.string(from: self as NSNumber)!
    }
}
