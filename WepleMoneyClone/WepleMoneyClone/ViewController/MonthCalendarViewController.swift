//
//  MonthCalendarViewController.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/04.
//

import Foundation
import UIKit

final class MonthCalendarViewController: UIViewController {
    lazy var calendarView: MonthCalendarCollectionView = {
        let calendarView: MonthCalendarCollectionView = MonthCalendarCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        calendarView.backgroundColor = .clear
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.isScrollEnabled = false
        return calendarView
    }()
    
    lazy var dateformatter: DateFormatter = {
        let dateformatter: DateFormatter = DateFormatter()
        dateformatter.dateFormat = "yyyy MM dd"
        dateformatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateformatter
    }()
    
    var currentYear: Int? {
        didSet {
            if let currentYear = currentYear {
                calendarView.currentYear = currentYear
            }
        }
    }
    var currentMonth: Int? {
        didSet {
            if let currentMonth = currentMonth {
                calendarView.currentMonth = currentMonth
            }
        }
    }
    var currentDay: Int? {
        didSet {
            if let currentDay = currentDay {
                calendarView.currentDay = currentDay
            }
        }
    }
    
    var expenseInfoList: [ExpenseInfoModel] = [] {
        didSet {
            calendarView.expenseInfoList = expenseInfoList
        }
    }
    
    var showDailyHistoryInfo: (([ExpenseInfoModel]) -> Void)?
    var reloadDailyHistoryInfoIfNeeded: (([ExpenseInfoModel]) -> Void)?
    
    private var expenseDAO: ExpenseDAO = ExpenseDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        self.view.addSubview(calendarView)
        calendarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        calendarView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        calendarView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        self.calendarView.register(MonthCalendarCollectionViewCell.self, forCellWithReuseIdentifier: MonthCalendarCollectionViewCell.identifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAddHistoryNotification(_:)), name: NSNotification.Name("AddHistoryNotification"), object: nil)   // 입금/지출 등록후, 모달이 모두 닫히고 돌아왔을때 캘린더뷰에 등록된 내역이 노출되지 않는문제.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.calendarView.reloadData()  // 뷰컨 페이징시 콜렉션뷰 선택된 셀 초기화되지 않는 문제.

        let selectedDate: Date? = SingleTon.shared.selectedDate
        if selectedDate != nil {
            // 앱 첫 실행후, 오늘날짜에 해당하는 테이블뷰가 노출되지 않는 문제해결을 위한 처리
            let selectedDateFetchResult: [ExpenseInfoModel] = expenseDAO.fetchAtCertainDate(date: selectedDate!)
            self.reloadDailyHistoryInfoIfNeeded?(selectedDateFetchResult)
        }
    }
    
    deinit {
        print("###current MonthCalenderVC deinit. \(currentYear!)년 \(currentMonth!)월###")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("AddHistoryNotification"), object: nil)
    }

    @objc private func didReceiveAddHistoryNotification(_ notification: Notification) {
        if currentYear == nil || currentMonth == nil { return }
        
        print("###didReceiveAddHistoryNotification###")
        print("\(currentYear!)년 \(currentMonth!)월")
        
        let fetchResult: [ExpenseInfoModel] = expenseDAO.fetch(yearMonth: "\(String(describing: currentYear!))\(String(format: "%02d", currentMonth!))")
        self.expenseInfoList = fetchResult
        
        let filterSelectedDayFetchResult: [ExpenseInfoModel] = fetchResult.filter { $0.date == SingleTon.shared.selectedDate }
        self.reloadDailyHistoryInfoIfNeeded?(filterSelectedDayFetchResult)
    }
}
