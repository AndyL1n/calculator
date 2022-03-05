//
//  CalculateViewModel.swift
//  main_2022
//
//  Created by Andy on 2022/3/2.
//

import Foundation
import CaculateCore

public struct CalculateViewModel {
    private var selectedOperator: CalculatorButtonType? = nil
    private var ans: Double = 0
    private var inputs: String =  ""
    private var isError = false
    private var isNegative = false
    private var lastInput: Double = 0
    private let maxInput = 9
    private let formatterUpperBreakPoint = 999999999.9
    private let formatterLowerBreakPoint = 0.000000001
    private let decimalFormatter = NumberFormatter()
    private let scientificFormatter = NumberFormatter()
    
    init() {
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.groupingSeparator = ","
        decimalFormatter.maximumIntegerDigits = maxInput
        decimalFormatter.maximumSignificantDigits = maxInput + 1
        scientificFormatter.numberStyle = .scientific
        scientificFormatter.maximumSignificantDigits = maxInput + 1
    }
    
    public var displayedValue: String {
        get {
            if isError && inputs.isEmpty {
                return "Error"
            } else if !inputs.isEmpty {
                var parsedInputs = Double(inputs) ?? 0
                guard parsedInputs != 0 else {
                    // e.g. -0.00003
                    if isNegative {
                        return "-" + inputs
                    } else {
                        return inputs
                    }
                }
                if isNegative {
                    parsedInputs.negate()
                }
                var formattedInputs = decimalFormatter.string(from: NSNumber(value: parsedInputs)) ?? "0"
                if inputs.last == "." {
                    formattedInputs += "."
                }
                return formattedInputs
            } else if inputs.isEmpty && isNegative {
                return "-0"
            } else if ans != 0 {
                if abs(ans) < formatterUpperBreakPoint && formatterLowerBreakPoint < abs(ans) {
                    return decimalFormatter.string(from: NSNumber(value: ans)) ?? "0"
                } else {
                    return scientificFormatter.string(from: NSNumber(value: ans)) ?? "0"
                }
            } else {
                return "0"
            }
        }
    }
    
    
    mutating func onTypeNumber(_ number: Int) {
        print("Input number", number)
        if inputs.isEmpty {
            if number != 0 {
                inputs.append(String(number))
            }
        } else if inputs.count >= maxInput {
            if inputs.last == "." && inputs.count <= maxInput {
                inputs.append(String(number))
            }
        } else {
            inputs.append(String(number))
        }
    }
    
    mutating func onTypeDot() {
        print("dot typed")
        guard !inputs.contains(".") else {
            return
        }
        if inputs.count >= maxInput {
            // discard if pool is full
        } else if inputs.isEmpty {
            inputs.append("0.")
        } else {
            inputs.append(".")
        }
    }
    
    mutating func onAC() {
        print("AC")
        self.ans = 0
        self.inputs.removeAll()
        self.selectedOperator = nil
        self.isNegative = false
        self.isError = false
        self.lastInput = 0
    }
    
    mutating func onFactorial() {
        let inputNumber = Int(inputs) ?? 0
        
        isNegative = false
        inputs.removeAll()
        
        if inputNumber != 0 {
            lastInput = Double(inputNumber)
        }
        guard !isError else {
            return
        }
        ans = 1

        guard Int(lastInput) != 0 else {
            return
        }
        for index in 1...Int(lastInput) {
            ans = ans * Double(index)
        }
    }
    
    mutating func onSelectOperator(_ selectedOperator: CalculatorButtonType) {
        print("operator", selectedOperator)
        self.selectedOperator = selectedOperator
        let inputNumber = Double(inputs) ?? 0
        if inputNumber != 0 {
            ans = inputNumber
        }
        inputs.removeAll()
    }
    
    mutating func onCalculate() {
        print("calculate")
        var inputNumber = Double(inputs) ?? 0
        if isNegative {
            inputNumber.negate()
        }
        
        isNegative = false
        inputs.removeAll()
        
        if inputNumber != 0 {
            lastInput = inputNumber
        }
        
        guard !isError else {
            return
        }
        
        switch selectedOperator {
        case nil:
            ans = lastInput
        case .Plus:
            ans += lastInput
        case .Minus:
            ans -= lastInput
        case .Multiply:
            ans *= lastInput
        case .Divide:
            guard lastInput != 0 else {
                isError = true
                ans = 0
                lastInput = 0
                return
            }
            ans /= lastInput
        default:
            break
        }
    }
}
