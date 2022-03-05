//
//  MainViewController.swift
//  main_2022
//
//  Created by Andy on 2022/3/2.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var demoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.text = "計算機"
        titleLabel.font = .semibold(size: 80)
        titleLabel.adjustsFontSizeToFitWidth = true
        nameLabel.text = "林欣緯"
        nameLabel.font = .regular(size: 20)
        demoButton.setTitle("START DEMO", for: .normal)
        demoButton.titleLabel?.font = .semibold(size: 20)
        demoButton.backgroundColor = .orange
        demoButton.tintColor = .white
        demoButton.layer.cornerRadius = demoButton.frame.height / 2
        demoButton.addTarget(self, action: #selector(demoAction), for: .touchUpInside)
    }
    
    @objc func demoAction() {
        let vc = CalculatorViewController.new
        present(vc, animated: true, completion: nil)
    }
}
