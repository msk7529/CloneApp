//
//  MonthCalendarCollectionViewCell.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/04.
//

import Foundation
import UIKit

final class MonthCalendarCollectionViewCell: UICollectionViewCell {
    static let height: CGFloat = 55
    static let identifier: String = "MonthCalendarCollectionViewCell"
    
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
