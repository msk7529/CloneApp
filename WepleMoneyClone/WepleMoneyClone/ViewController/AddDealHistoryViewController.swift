//
//  AddDealHistoryViewController.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/09.
//

import UIKit

final class AddDealHistoryViewController: UIViewController {
    
    lazy var dateLabel: UILabel = {
        let dateLabel: UILabel = UILabel(frame: .zero)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .lightGray
        dateLabel.font = UIFont.systemFont(ofSize: 17)
        dateLabel.text = parseSelectedDate()
        return dateLabel
    }()
    
    lazy var closeButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    lazy var wonLabel: UILabel = {
        let wonLabel: UILabel = UILabel(frame: .zero)
        wonLabel.translatesAutoresizingMaskIntoConstraints = false
        wonLabel.textColor = .black
        wonLabel.font = UIFont.systemFont(ofSize: 70)
        wonLabel.text = "₩"
        return wonLabel
    }()
    
    lazy var moneyField: UITextField = {
        let moneyField: UITextField = UITextField(frame: .zero)
        moneyField.translatesAutoresizingMaskIntoConstraints = false
        moneyField.textColor = .systemBlue
        moneyField.font = UIFont.systemFont(ofSize: 70)
        moneyField.textAlignment = .right
        moneyField.keyboardType = .numberPad
        moneyField.becomeFirstResponder()
        moneyField.text = "0"
        moneyField.addTarget(self, action: #selector(moneyFieldDidChange), for: .editingChanged)
        return moneyField
    }()
    
    lazy var incomeButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("입금", for: .normal)
        button.addTarget(self, action: #selector(incomeButtonDidTap), for: .touchUpInside)
        button.backgroundColor = UIColor(rgb: 0x52C66E)
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var expenseButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("지출", for: .normal)
        button.addTarget(self, action: #selector(expenseButtonDidTap), for: .touchUpInside)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
    }
    
    private func makeUI() {
        self.view.addSubview(dateLabel)
        self.view.addSubview(closeButton)
        self.view.addSubview(wonLabel)
        self.view.addSubview(moneyField)
        self.view.addSubview(incomeButton)
        self.view.addSubview(expenseButton)
        
        dateLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        
        closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        closeButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        wonLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 50).isActive = true
        wonLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        
        moneyField.topAnchor.constraint(equalTo: wonLabel.topAnchor, constant: -7).isActive = true
        moneyField.rightAnchor.constraint(equalTo: closeButton.rightAnchor).isActive = true
        moneyField.leftAnchor.constraint(equalTo: wonLabel.rightAnchor, constant: 20).isActive = true
        
        incomeButton.topAnchor.constraint(equalTo: wonLabel.bottomAnchor, constant: 60).isActive = true
        incomeButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 55).isActive = true
        incomeButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: -20).isActive = true
        incomeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        expenseButton.topAnchor.constraint(equalTo: incomeButton.topAnchor).isActive = true
        expenseButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 20).isActive = true
        expenseButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -55).isActive = true
        expenseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func parseSelectedDate() -> String {
        guard let selectedDate = SingleTon.shared.selectedDate else {
            return ""
        }
        
        let dateformatter: DateFormatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        dateformatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateformatter.string(from: selectedDate)
    }
    
    @objc private func closeButtonDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func incomeButtonDidTap() {
        
    }
    
    @objc private func expenseButtonDidTap() {
        if let selectExpenseCategoryVC = self.storyboard?.instantiateViewController(identifier: "SelectExpenseCategoryViewController") as? SelectExpenseCategoryViewController {
            let transition: CATransition = CATransition()
            transition.type = CATransitionType.push
            transition.duration = 0.3
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            
            selectExpenseCategoryVC.modalPresentationStyle = .fullScreen
            selectExpenseCategoryVC.expensePrice = moneyField.text ?? "0"
            self.present(selectExpenseCategoryVC, animated: false, completion: nil)
        }
    }
    
    @objc private func moneyFieldDidChange() {
        guard let text = moneyField.text else { return }
        
        if !text.isEmpty {
            if text.first == "0" {
                let returnText: String = String(text.dropFirst(1))
                moneyField.text = returnText
            }
        } else {
            moneyField.text = "0"
        }
    }
}
