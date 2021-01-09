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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.calendarView.reloadData()  // 뷰컨 페이징시 콜렉션뷰셀 미초기화 방지
    }
}
