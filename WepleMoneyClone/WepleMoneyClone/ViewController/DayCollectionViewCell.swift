//
//  dayCollectionView.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/02.
//

import Foundation
import UIKit

final class DayCollectionViewCell: UICollectionViewCell {
    lazy var dayLabel: UILabel = {
        let dayLabel: UILabel = UILabel(frame: .zero)
        dayLabel.font = UIFont.systemFont(ofSize: 8)
        dayLabel.textColor = UIColor(rgb: 0x3F3F3F)
        dayLabel.textAlignment = .center
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        return dayLabel
    }()
    
    var day: String = "월" {
        didSet {
            dayLabel.text = day
        }
    }
    
    static let height: CGFloat = 10
    static let identifier: String = "DayCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeUI() {
        self.contentView.addSubview(dayLabel)
        
        self.dayLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.dayLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.dayLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        self.dayLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
    }
}
