//
//  MonthCalendarTableView.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/12.
//

import Foundation
import UIKit

final class DailyHistoryInfoTableView: UITableView {
    enum Status {
        case empty
        case notEmpty
    }
    
    var expenseInfo: [ExpenseInfoModel] = []
    var incomeInfo: [IncomeInfoModel] = []
    
    var status: Status {
        get {
            if expenseInfo.isEmpty && incomeInfo.isEmpty {
                self.separatorStyle = .none     // 셀 구분선 없도록 처리
                return .empty
            } else {
                self.separatorStyle = .singleLine
                return .notEmpty
            }
        }
    }
}
