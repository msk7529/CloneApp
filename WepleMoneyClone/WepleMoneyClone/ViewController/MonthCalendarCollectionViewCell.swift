//
//  MonthCalendarCollectionViewCell.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/04.
//

import Foundation
import UIKit

enum cellStatus {
    case selected
    case unselected
}

final class MonthCalendarCollectionViewCell: UICollectionViewCell {
    static let height: CGFloat = 55
    static let identifier: String = "MonthCalendarCollectionViewCell"
    
    var currentDayString: String!
    var currentDate: Date!
    
    lazy var dayLabel: UILabel = {
        let dayLabel: UILabel = UILabel(frame: .zero)
        dayLabel.font = UIFont.systemFont(ofSize: 12)
        dayLabel.textColor = .black
        dayLabel.textAlignment = .center
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        return dayLabel
    }()
    
    lazy var expenseMoneyLabel: UILabel = {
        let expenseMoneyLabel: UILabel = UILabel(frame: .zero)
        expenseMoneyLabel.font = UIFont.systemFont(ofSize: 10)
        expenseMoneyLabel.textColor = UIColor(rgb: 0xF68DA9)
        expenseMoneyLabel.textAlignment = .center
        expenseMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        return expenseMoneyLabel
    }()
        
    var isCurrentMonth: Bool = true
    
    var isToday: Bool = false {
        didSet {
            if isToday == true {
                dayLabel.font = UIFont.boldSystemFont(ofSize: 12)
                dayLabel.textColor = .red
                self.contentView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.05)
            } else {
                if isCurrentMonth == false {
                    dayLabel.textColor = .lightGray
                } else if currentDayString == "토" {
                    dayLabel.textColor = .systemPink
                } else if currentDayString == "일" {
                    dayLabel.textColor = .systemBlue
                } else {
                    dayLabel.textColor = .black
                }
                dayLabel.font = UIFont.systemFont(ofSize: 12)
                self.contentView.backgroundColor = .clear
            }
        }
    }
    
    var expenseModel: [ExpenseInfoModel] = [] {
        didSet {
            if !expenseModel.isEmpty && isCurrentMonth == true {
                let totalPrice: Int32 = caculateTotalPrice()
                expenseMoneyLabel.text = String(totalPrice)
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected == true {
                dayLabel.textColor = .white
                dayLabel.font = UIFont.boldSystemFont(ofSize: 12)
                expenseMoneyLabel.textColor = .white
                self.contentView.backgroundColor = UIColor(rgb: 0xFFAADD)
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowRadius = 30
                self.layer.shadowOpacity = 0.2
                
                if isCurrentMonth == true {
                    SingleTon.shared.selectedDate = currentDate
                } else {
                    dayLabel.textColor = .lightGray
                }
            } else {
                isToday = isToday == true ? true : false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.isCurrentMonth = true
        self.dayLabel.text = ""
        self.dayLabel.textColor = .black
        self.expenseMoneyLabel.textColor = UIColor(rgb: 0xF68DA9)
        self.expenseMoneyLabel.text = ""
    }
    
    private func makeUI() {
        self.contentView.addSubview(dayLabel)
        self.contentView.addSubview(expenseMoneyLabel)
        
        dayLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        dayLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        dayLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        expenseMoneyLabel.topAnchor.constraint(equalTo: self.dayLabel.bottomAnchor, constant: 5).isActive = true
        expenseMoneyLabel.leftAnchor.constraint(equalTo: self.dayLabel.leftAnchor).isActive = true
        expenseMoneyLabel.rightAnchor.constraint(equalTo: self.dayLabel.rightAnchor).isActive = true
    }
    
    private func caculateTotalPrice() -> Int32 {
        let prices: [Int32] = self.expenseModel.map( {$0.price ?? 0} )
        return prices.reduce(0){ $0 + $1 }
    }
}
