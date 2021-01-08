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
    
    lazy var dayLabel: UILabel = {
        let dayLabel: UILabel = UILabel(frame: .zero)
        dayLabel.font = UIFont.systemFont(ofSize: 12)
        dayLabel.textColor = .black
        dayLabel.textAlignment = .center
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        return dayLabel
    }()
        
    var isCurrentMonth: Bool = true {
        didSet {
            if isCurrentMonth == false {
                dayLabel.textColor = .lightGray
            }
        }
    }
    
    var isToday: Bool = false {
        didSet {
            if isToday == true {
                dayLabel.font = UIFont.boldSystemFont(ofSize: 12)
                dayLabel.textColor = .red
                self.contentView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.05)
            } else {
                if currentDayString == "토" {
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
    
    override var isSelected: Bool {
        didSet {
            if isSelected == true {
                dayLabel.textColor = .white
                dayLabel.font = UIFont.boldSystemFont(ofSize: 12)
                self.contentView.backgroundColor = UIColor(rgb: 0xFFAADD)
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowRadius = 30
                self.layer.shadowOpacity = 0.2
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
        
        self.dayLabel.text = ""
        self.dayLabel.textColor = .black
    }
    
    private func makeUI() {
        self.contentView.addSubview(dayLabel)
        
        dayLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        dayLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        dayLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
}
