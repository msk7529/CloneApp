//
//  MonthViewController+UITableView.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/12.
//

import Foundation
import UIKit

extension MonthViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableView = tableView as? DailyHistoryInfoTableView else { return 0 }
        
        return tableView.expenseInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tableView = tableView as? DailyHistoryInfoTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyHistoryInfoTableViewCell.identifier, for: indexPath) as? DailyHistoryInfoTableViewCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.expenseInfo = tableView.expenseInfo[indexPath.row]
            
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DailyHistoryInfoTableViewCell.height
    }
}
