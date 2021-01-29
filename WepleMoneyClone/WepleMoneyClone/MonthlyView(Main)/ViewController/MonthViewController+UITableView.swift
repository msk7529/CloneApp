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
        
        if tableView.status == .empty {
            return 1
        } else {
            return tableView.expenseInfo.count + tableView.incomeInfo.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tableView = tableView as? DailyHistoryInfoTableView {
            if tableView.status == .notEmpty {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyHistoryInfoTableViewCell.identifier, for: indexPath) as? DailyHistoryInfoTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.selectionStyle = .none
                
                if tableView.incomeInfo.isEmpty == true {
                    cell.expenseInfo = tableView.expenseInfo[indexPath.row]
                } else {
                    if indexPath.row < tableView.incomeInfo.count {
                        cell.incomeInfo = tableView.incomeInfo[indexPath.row]
                    } else {
                        cell.expenseInfo = tableView.expenseInfo[tableView.expenseInfo.count - indexPath.row]
                    }
                }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyHistoryInfoTableViewEmptyCell.identifier, for: indexPath) as? DailyHistoryInfoTableViewEmptyCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let tableView = tableView as? DailyHistoryInfoTableView else { return 0 }

        if tableView.status == .empty {
            return tableView.frame.size.height
        } else {
            return DailyHistoryInfoTableViewCell.height
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let ReceiptDetailVC = self.storyboard?.instantiateViewController(identifier: "ReceiptDetailViewController") as? ReceiptDetailViewController {
            if let cell = tableView.cellForRow(at: indexPath) as? DailyHistoryInfoTableViewCell {
                ReceiptDetailVC.expenseInfo = cell.expenseInfo
                ReceiptDetailVC.incomeInfo = cell.incomeInfo
                
                self.navigationController?.pushViewController(ReceiptDetailVC, animated: true)
            }
        }
    }
}
