//
//  CalculatorViewController.swift
//  main_2022
//
//  Created by Andy on 2022/3/2.
//

import UIKit
import CaculateCore

class CalculatorViewController: UIViewController {
    static var new: CalculatorViewController {
        return UIStoryboard.Main.newInstance(typeName: "CalculatorViewController") as! CalculatorViewController
    }
    
    @IBOutlet weak var calculateDiaplyLabel: UILabel!
    @IBOutlet weak var caculatorBoard: UIStackView!
    @IBOutlet weak var boardHeight: NSLayoutConstraint!
    
    private var viewModel: CalculateViewModel = CalculateViewModel()
    
    private let caculateDisplaySort: [[CalculatorButtonType]] = [
        [.Number7, .Number8, .Number9, .Divide],
        [.Number4, .Number5, .Number6, .Multiply],
        [.Number1, .Number2, .Number3, .Minus],
        [.Number0, .Dot, .Calculate, .Plus],
        [.AC, .Factorial]
    ]
    
    private let caculateButtonInset: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        calculateDiaplyLabel.text = "0"
        calculateDiaplyLabel.font = .semibold(size: 100)
        calculateDiaplyLabel.adjustsFontSizeToFitWidth = true
        let buttonSize = (view.frame.width - 30 - caculateButtonInset * 3) / CGFloat(caculateDisplaySort.count)
        _ = caculatorBoard.then {
            $0.distribution = .fillEqually
            $0.spacing = caculateButtonInset
        }
        
        func calculateButton(with type: CalculatorButtonType) -> UIButton {
            return UIButton(type: .custom).then {
                $0.setTitle(type.symbol, for: .normal)
                $0.titleLabel?.font = .semibold(size: 30)
                $0.setTitleColor(.white, for: .normal)
                $0.backgroundColor = type.backgroundColor
                $0.frame.size = .init(width: buttonSize, height: buttonSize)
                $0.makeRadius(radius: buttonSize / 2)
                $0.tag = type.rawValue
                $0.addTarget(self, action: #selector(onCaculateButtonType(_:)), for: .touchUpInside)
            }
        }
        caculateDisplaySort.forEach {
            let buttonList = UIStackView().then {
                $0.distribution = .fillEqually
                $0.spacing = caculateButtonInset
            }
            $0.forEach { buttonList.addArrangedSubview(calculateButton(with: $0)) }
            caculatorBoard.addArrangedSubview(buttonList)
        }
        boardHeight.constant = buttonSize * CGFloat(caculateDisplaySort.count) + caculateButtonInset * 3
    }
    
    @objc func onCaculateButtonType(_ sender: UIButton) {
        guard let buttonType = CalculatorButtonType(rawValue: sender.tag) else { return }
        onControlPanelClick(buttonType)
    }
    
    private func onControlPanelClick(_ keyType: CalculatorButtonType) {
        switch keyType {
        case .Plus, .Minus, .Multiply, .Divide:
            viewModel.onSelectOperator(keyType)
        case .AC:
            viewModel.onAC()
        case .Dot:
            viewModel.onTypeDot()
        case .Calculate:
            viewModel.onCalculate()
        case .Factorial:
            viewModel.onFactorial()
        default:
            viewModel.onTypeNumber(keyType.rawValue)
        }
        calculateDiaplyLabel.text = viewModel.displayedValue
    }
}
