//
//  MonthViewController.swift
//  WepleMoneyClone
//
//  Created by kakao on 2020/12/09.
//

import UIKit
import Foundation

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
    
    lazy var dayCollecionView: DayCollectionView = {
        let dayCollecionView: DayCollectionView = DayCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        // collectionViewLayout에 UICollectionViewLayout() 넣으면 cellForItemAt, UICollectionViewDelegateFlowLayout 동작 안함...
        dayCollecionView.backgroundColor = .clear
        dayCollecionView.translatesAutoresizingMaskIntoConstraints = false
        dayCollecionView.isScrollEnabled = false
        return dayCollecionView
    }()
    
    lazy var seperlatorLine: UIView = {
        let seperlatorLine: UIView = UIView(frame: .zero)
        seperlatorLine.translatesAutoresizingMaskIntoConstraints = false
        seperlatorLine.backgroundColor = .lightGray
        return seperlatorLine
    }()
    
    lazy var calendarView: MonthCalendarCollectionView = {
        let calendarView: MonthCalendarCollectionView = MonthCalendarCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        calendarView.backgroundColor = .clear
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.isScrollEnabled = false
        return calendarView
    }()
    
    lazy var seperlatorLine2: UIView = {
        let seperlatorLine: UIView = UIView(frame: .zero)
        seperlatorLine.translatesAutoresizingMaskIntoConstraints = false
        seperlatorLine.backgroundColor = UIColor(rgb: 0x3F3F3F)
        return seperlatorLine
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.currentMonth = 1
        
        makeUI()
        constructCollectionViews()
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
        self.view.addSubview(dayCollecionView)
        self.view.addSubview(seperlatorLine)
        self.view.addSubview(calendarView)
        self.view.addSubview(seperlatorLine2)
        
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
        
        expenseMoney.topAnchor.constraint(equalTo: self.incomeMoney.topAnchor).isActive = true
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
        
        dayCollecionView.topAnchor.constraint(equalTo: self.balanceMoney.bottomAnchor, constant: 9).isActive = true
        dayCollecionView.leftAnchor.constraint(equalTo: self.income.leftAnchor).isActive = true
        dayCollecionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        dayCollecionView.heightAnchor.constraint(equalToConstant: DayCollectionViewCell.height).isActive = true
        
        seperlatorLine.topAnchor.constraint(equalTo: self.dayCollecionView.bottomAnchor, constant: 2).isActive = true
        seperlatorLine.leftAnchor.constraint(equalTo: dayCollecionView.leftAnchor).isActive = true
        seperlatorLine.rightAnchor.constraint(equalTo: dayCollecionView.rightAnchor).isActive = true
        seperlatorLine.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        
        calendarView.topAnchor.constraint(equalTo: self.seperlatorLine.bottomAnchor, constant: 3).isActive = true
        calendarView.leftAnchor.constraint(equalTo: seperlatorLine.leftAnchor).isActive = true
        calendarView.rightAnchor.constraint(equalTo: seperlatorLine.rightAnchor).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: MonthCalendarCollectionViewCell.height * CGFloat(calendarView.numOfRow)).isActive = true
        
        seperlatorLine2.topAnchor.constraint(equalTo: self.calendarView.bottomAnchor, constant: 7).isActive = true
        seperlatorLine2.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        seperlatorLine2.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        seperlatorLine2.heightAnchor.constraint(equalToConstant: 0.3).isActive = true    }

    private func constructCollectionViews() {
        self.dayCollecionView.delegate = self
        self.dayCollecionView.dataSource = self
        self.dayCollecionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.identifier)
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        self.calendarView.register(MonthCalendarCollectionViewCell.self, forCellWithReuseIdentifier: MonthCalendarCollectionViewCell.identifier)
    }
}

extension MonthViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView is DayCollectionView {
            return DayCollectionView.dayCount
        } else if collectionView is MonthCalendarCollectionView {
            return MonthCalendarCollectionView.dayCount
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let collectionView = collectionView as? DayCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.identifier, for: indexPath) as? DayCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.day = DayCollectionView.daySringArr[indexPath.row]
            return cell
        } else if let collectionView = collectionView as? MonthCalendarCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCalendarCollectionViewCell.identifier, for: indexPath) as? MonthCalendarCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.dayLabel.text = String(collectionView.dayArr[indexPath.row])
            
            let currentDayString: String = DayCollectionView.daySringArr[indexPath.row % 7]
            if currentDayString == "토" {
                cell.dayLabel.textColor = .systemBlue
            } else if currentDayString == "일" {
                cell.dayLabel.textColor = .systemPink
            }
            
            if indexPath.row < collectionView.startIndex || indexPath.row > collectionView.endIndex {
                cell.isCurrentMonth = false
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MonthViewController: UICollectionViewDelegate {
    
}

extension MonthViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀의 사이즈 정의
        if collectionView is DayCollectionView {
            return CGSize(width: collectionView.frame.width / 7, height: collectionView.frame.height)
        } else if collectionView is MonthCalendarCollectionView {
            return CGSize(width: collectionView.frame.width / 7, height: MonthCalendarCollectionViewCell.height)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 셀 간 세로간격 조정
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 셀 간 가로간격 조정
        return 0
    }
}
