//
//  SelectExpensePaymentViewController.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/12.
//

import UIKit

final class SelectExpensePaymentViewController: UIViewController {

    lazy var backButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.setImage(UIImage(named: "backButton"), for: .highlighted)
        button.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    lazy var cashLabel: UILabel = {
        let cashLabel: UILabel = UILabel(frame: .zero)
        cashLabel.translatesAutoresizingMaskIntoConstraints = false
        cashLabel.layer.cornerRadius = 22.5
        cashLabel.layer.borderColor = .none
        cashLabel.layer.backgroundColor = UIColor.systemPink.cgColor
        cashLabel.font = UIFont.systemFont(ofSize: 19)
        cashLabel.textColor = .white
        cashLabel.textAlignment = .center
        cashLabel.text = "현금"
        cashLabel.isUserInteractionEnabled = true   // tap gesture을 사용하기 위함
        return cashLabel
    }()
    
    lazy var checkCardLabel: UILabel = {
        let checkCardLabel: UILabel = UILabel(frame: .zero)
        checkCardLabel.translatesAutoresizingMaskIntoConstraints = false
        checkCardLabel.layer.cornerRadius = 22.5
        checkCardLabel.layer.borderColor = .none
        checkCardLabel.layer.backgroundColor = UIColor(rgb: 0x6ABA78).cgColor
        checkCardLabel.font = UIFont.systemFont(ofSize: 19)
        checkCardLabel.textColor = .white
        checkCardLabel.textAlignment = .center
        checkCardLabel.text = "체크카드"
        checkCardLabel.isUserInteractionEnabled = true   // tap gesture을 사용하기 위함
        return checkCardLabel
    }()
    
    lazy var creditCardLabel: UILabel = {
        let creditCardLabel: UILabel = UILabel(frame: .zero)
        creditCardLabel.translatesAutoresizingMaskIntoConstraints = false
        creditCardLabel.layer.cornerRadius = 22.5
        creditCardLabel.layer.borderColor = .none
        creditCardLabel.layer.backgroundColor = UIColor(rgb: 0x86D6FB).cgColor
        creditCardLabel.font = UIFont.systemFont(ofSize: 19)
        creditCardLabel.textColor = .white
        creditCardLabel.textAlignment = .center
        creditCardLabel.text = "신용카드"
        creditCardLabel.isUserInteractionEnabled = true   // tap gesture을 사용하기 위함
        return creditCardLabel
    }()
    
    var dataModel: ExpenseInfoModel?
    
    private let expenseDAO: ExpenseDAO = ExpenseDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizer1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cashLabelDidTap))
        let tapGestureRecognizer2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(checkCardLabelDidTap))
        let tapGestureRecognizer3: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(creditCardLabelDidTap))
        
        cashLabel.addGestureRecognizer(tapGestureRecognizer1)
        checkCardLabel.addGestureRecognizer(tapGestureRecognizer2)
        creditCardLabel.addGestureRecognizer(tapGestureRecognizer3)
        
        makeUI()
    }
    
    private func makeUI() {
        self.view.addSubview(backButton)
        self.view.addSubview(closeButton)
        self.view.addSubview(cashLabel)
        self.view.addSubview(checkCardLabel)
        self.view.addSubview(creditCardLabel)
        
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        backButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        
        closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        closeButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        cashLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 130).isActive = true
        cashLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        cashLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        cashLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        checkCardLabel.topAnchor.constraint(equalTo: self.cashLabel.bottomAnchor, constant: 15).isActive = true
        checkCardLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        checkCardLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        checkCardLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        creditCardLabel.topAnchor.constraint(equalTo: self.checkCardLabel.bottomAnchor, constant: 15).isActive = true
        creditCardLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        creditCardLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        creditCardLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    @objc private func backButtonDidTap() {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
                
        self.dismiss(animated: false)
    }
    
    @objc private func closeButtonDidTap() {
        var currentVC: UIViewController? = self     // 현재 뷰컨
        
        while(currentVC != nil) {
            let tmpVC: UIViewController? = currentVC?.presentingViewController  // 현재 뷰컨을 present시킨 뷰컨
            
            if(tmpVC?.presentedViewController == nil) {     // tmpVC에 의해 present 되어진 뷰컨
                currentVC?.dismiss(animated: true, completion: nil)
                break
            }
            currentVC = tmpVC
        }
    }
    
    @objc private func cashLabelDidTap() {
        print("cash label did Tap")
        
        guard let model = dataModel else {
            print("Error occured in cashLabelDidTap function")
            return
        }
        model.payment = "현금"
        
        expenseDAO.saveHistory(model)
        
        closeButtonDidTap()
    }
    
    @objc private func checkCardLabelDidTap() {
        print("checkCard label did Tap")
        
        let test = expenseDAO.fetch(yearMonth: dataModel?.yearMonth ?? "202101")
        for tt in test {
            print(tt.category)
        }
    }
    
    @objc func creditCardLabelDidTap() {
        print("creditCard label did Tap")
    }
}
