//
//  MonthCalendarTableViewCell.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/12.
//

import UIKit
import Foundation

final class DailyHistoryInfoTableViewCell: UITableViewCell {
    static let identifier: String = "DailyHistoryInfoTableViewCell"
    static let height: CGFloat = 40
    
    lazy var categoryLabel: UILabel = {
        let categoryLabel: UILabel = UILabel(frame: .zero)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.backgroundColor = .clear
        categoryLabel.textAlignment = .center
        categoryLabel.textColor = .lightGray
        categoryLabel.font = UIFont.systemFont(ofSize: 16)
        return categoryLabel
    }()
    
    lazy var priceLabel: UILabel = {
        let priceLabel: UILabel = UILabel(frame: .zero)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.backgroundColor = .clear
        priceLabel.textAlignment = .right
        priceLabel.textColor = .systemGreen
        priceLabel.font = UIFont.systemFont(ofSize: 20)
        return priceLabel
    }()
    
    var expenseInfo: ExpenseInfoModel? {
        didSet {
            categoryLabel.text = expenseInfo?.category ?? "카테고리오류"
            priceLabel.text = String(expenseInfo?.price ?? 0) + "원"
            priceLabel.textColor = UIColor(rgb: 0xE6787B)
        }
    }
    
    var incomeInfo: IncomeInfoModel? {
        didSet {
            categoryLabel.text = incomeInfo?.category ?? "카테고리오류"
            priceLabel.text = String(incomeInfo?.price ?? 0) + "원"
            priceLabel.textColor = UIColor(rgb: 0x47A645)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeUI() {
        self.contentView.addSubview(categoryLabel)
        self.contentView.addSubview(priceLabel)
        
        categoryLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        categoryLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
        
        priceLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20).isActive = true
        priceLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        priceLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
    }
}
