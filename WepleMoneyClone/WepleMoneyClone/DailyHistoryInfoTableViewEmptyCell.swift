//
//  DailyHistoryInfoTableViewEmptyCell.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/29.
//

import UIKit
import Foundation

final class DailyHistoryInfoTableViewEmptyCell: UITableViewCell {
    static let identifier: String = "DailyHistoryInfoTableViewEmptyCell"
    
    private lazy var emptyLabel: UILabel = {
        let emptyLabel: UILabel = UILabel(frame: .zero)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.backgroundColor = .clear
        emptyLabel.text = "데이터가 없습니다."
        emptyLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        emptyLabel.textColor = .systemGray
        return emptyLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeUI() {
        self.contentView.addSubview(emptyLabel)
        
        emptyLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
}
