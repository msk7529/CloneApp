//
//  ExpenseCategoryCollectionViewCell.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/12.
//

import Foundation
import UIKit

final class ExpenseCategoryCollectionViewCell: UICollectionViewCell {
    
    static let height: CGFloat = 60
    static let identifier: String = "ExpenseCategoryCollectionViewCell"
    
    lazy var categoryLabel: UILabel = {
        let categoryLabel: UILabel = UILabel(frame: .zero)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.layer.cornerRadius = 30
        categoryLabel.layer.borderColor = UIColor.black.cgColor
        categoryLabel.layer.borderWidth = 1
        categoryLabel.font = UIFont.systemFont(ofSize: 13)
        categoryLabel.textColor = .gray
        categoryLabel.textAlignment = .center
        return categoryLabel
    }()
    
    var category: String = "" {
        didSet {
            categoryLabel.text = category
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeUI() {
        self.contentView.addSubview(categoryLabel)
        
        categoryLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        categoryLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        categoryLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        categoryLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
    }
}
