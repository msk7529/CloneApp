//
//  MonthViewController.swift
//  WepleMoneyClone
//
//  Created by kakao on 2020/12/09.
//

import UIKit

final class MonthViewController: UIViewController {

    lazy var income: UILabel = {
        let income: UILabel = UILabel()
        income.text = "수입"
        income.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        income.textColor = .black
        income.translatesAutoresizingMaskIntoConstraints = false
        return income
    }()
    
    lazy var incomeMoney: UILabel = {
        let incomeMoney: UILabel = UILabel()
        incomeMoney.text = "0원"
        incomeMoney.font = UIFont.systemFont(ofSize: 23)
        incomeMoney.textColor = .systemGreen
        incomeMoney.textAlignment = .right
        incomeMoney.translatesAutoresizingMaskIntoConstraints = false
        return incomeMoney
    }()
    
    lazy var balance: UILabel = {
        let balance: UILabel = UILabel()
        balance.text = "현금 잔액"
        balance.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        balance.textColor = .black
        balance.translatesAutoresizingMaskIntoConstraints = false
        return balance
    }()
    
    lazy var balanceMoney: UILabel = {
        let balanceMoney: UILabel = UILabel()
        balanceMoney.text = "0원"
        balanceMoney.font = UIFont.systemFont(ofSize: 23)
        balanceMoney.textColor = .gray
        balanceMoney.textAlignment = .right
        balanceMoney.translatesAutoresizingMaskIntoConstraints = false
        return balanceMoney
    }()
    
    lazy var expense: UILabel = {
        let expense: UILabel = UILabel()
        expense.text = "지출"
        expense.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        expense.textColor = .black
        expense.translatesAutoresizingMaskIntoConstraints = false
        return expense
    }()
    
    lazy var expenseMoney: UILabel = {
        let expenseMoney: UILabel = UILabel()
        expenseMoney.text = "0원"
        expenseMoney.font = UIFont.systemFont(ofSize: 23)
        expenseMoney.textColor = .systemPink
        expenseMoney.textAlignment = .right
        expenseMoney.translatesAutoresizingMaskIntoConstraints = false
        return expenseMoney
    }()
    
    lazy var cash: UILabel = {
        let cash: UILabel = UILabel()
        cash.text = "현금"
        cash.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 3)
        cash.textColor = .lightGray
        cash.translatesAutoresizingMaskIntoConstraints = false
        return cash
    }()
    
    lazy var cashMoney: UILabel = {
        let cashMoney: UILabel = UILabel()
        cashMoney.text = "0"
        cashMoney.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 1)
        cashMoney.textColor = .lightGray
        cashMoney.textAlignment = .right
        cashMoney.translatesAutoresizingMaskIntoConstraints = false
        return cashMoney
    }()
    
    lazy var card: UILabel = {
        let card: UILabel = UILabel()
        card.text = "카드"
        card.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 3)
        card.textColor = .lightGray
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    lazy var cardMoney: UILabel = {
        let cardMoney: UILabel = UILabel()
        cardMoney.text = "0"
        cardMoney.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 1)
        cardMoney.textColor = .lightGray
        cardMoney.textAlignment = .right
        cardMoney.translatesAutoresizingMaskIntoConstraints = false
        return cardMoney
    }()
    
    lazy var mergeImage: UIImageView = {
        let mergeImage: UIImageView = UIImageView(image: UIImage(named: "image1"))
        mergeImage.translatesAutoresizingMaskIntoConstraints = false
        return mergeImage
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    
    private func makeUI() {
        self.view.addSubview(income)
        self.view.addSubview(balance)
        self.view.addSubview(incomeMoney)
        self.view.addSubview(balanceMoney)
        self.view.addSubview(expense)
        self.view.addSubview(expenseMoney)
        self.view.addSubview(cash)
        self.view.addSubview(cashMoney)
        self.view.addSubview(card)
        self.view.addSubview(cardMoney)
        self.view.addSubview(mergeImage)
        
        income.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        income.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        income.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        incomeMoney.topAnchor.constraint(equalTo: self.income.topAnchor, constant: -7).isActive = true
        incomeMoney.leftAnchor.constraint(equalTo: self.income.rightAnchor, constant: 5).isActive = true
        incomeMoney.widthAnchor.constraint(equalToConstant: 115).isActive = true
                
        balance.topAnchor.constraint(equalTo: self.income.bottomAnchor, constant: 20).isActive = true
        balance.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        balance.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        balanceMoney.topAnchor.constraint(equalTo: self.balance.topAnchor, constant: -7).isActive = true
        balanceMoney.leftAnchor.constraint(equalTo: self.balance.rightAnchor, constant: 5).isActive = true
        balanceMoney.widthAnchor.constraint(equalToConstant: 115).isActive = true
        
        expense.topAnchor.constraint(equalTo: self.income.topAnchor).isActive = true
        expense.leftAnchor.constraint(equalTo: self.incomeMoney.rightAnchor, constant: 15).isActive = true
        expense.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        expenseMoney.topAnchor.constraint(equalTo: self.incomeMoney.topAnchor, constant: -7).isActive = true
        expenseMoney.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        expenseMoney.widthAnchor.constraint(equalToConstant: 115).isActive = true
        
        cash.topAnchor.constraint(equalTo: self.expense.bottomAnchor, constant: 7).isActive = true
        cash.leftAnchor.constraint(equalTo: self.expense.leftAnchor, constant: 25).isActive = true
        cash.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        cashMoney.topAnchor.constraint(equalTo: self.cash.topAnchor, constant: -1).isActive = true
        cashMoney.rightAnchor.constraint(equalTo: self.expenseMoney.rightAnchor).isActive = true
        cashMoney.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        card.topAnchor.constraint(equalTo: self.cash.bottomAnchor, constant: 4).isActive = true
        card.leftAnchor.constraint(equalTo: self.cash.leftAnchor).isActive = true
        card.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        cardMoney.topAnchor.constraint(equalTo: self.card.topAnchor, constant: -1).isActive = true
        cardMoney.rightAnchor.constraint(equalTo: self.expenseMoney.rightAnchor).isActive = true
        cardMoney.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        mergeImage.topAnchor.constraint(equalTo: self.cash.centerYAnchor, constant: -2).isActive = true
        mergeImage.rightAnchor.constraint(equalTo: self.cash.leftAnchor, constant: -3).isActive = true
        mergeImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }

}
