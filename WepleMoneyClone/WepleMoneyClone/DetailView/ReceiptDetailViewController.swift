//
//  ReceiptDetailViewController.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/27.
//

import UIKit
import Foundation

final class ReceiptDetailViewController: UIViewController {

    var incomeInfo: IncomeInfoModel? {
        didSet {
            
        }
    }
    
    var expenseInfo: ExpenseInfoModel? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNav()
    }
    
    private func initNav() {
        self.navigationController?.navigationBar.tintColor = UIColor(rgb: 0x864143)     // navigation items와 barButtonItems에 적용되는 색상
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black ]      // 네비게이션 타이틀에 적용되는 색상
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0xF8F9F6)  // 네비게이션바 배경에 적용되는 색상
        
        if self.incomeInfo != nil {
            self.navigationItem.title = "입금 영수증"
        } else {
            self.navigationItem.title = "지출 영수증"
        }
        
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: .remove, style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}
