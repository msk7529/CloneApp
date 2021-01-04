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
    
    var currentYear: Int! {
        didSet {
            calendarView.currentYear = currentYear
        }
    }
    var currentMonth: Int! {
        didSet {
            calendarView.currentMonth = currentMonth
        }
    }
    var todayYearMonth: (Int, Int)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setNavigationTitle()
                
        self.view.addSubview(calendarView)
        calendarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        calendarView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        calendarView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        self.calendarView.register(MonthCalendarCollectionViewCell.self, forCellWithReuseIdentifier: MonthCalendarCollectionViewCell.identifier)
    }
}

extension MonthCalendarViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let collectionView = collectionView as? MonthCalendarCollectionView else {
            return 0
        }
        return collectionView.dayArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let collectionView = collectionView as? MonthCalendarCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCalendarCollectionViewCell.identifier, for: indexPath) as? MonthCalendarCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.dayLabel.text = String(collectionView.dayArr[indexPath.row])
            
            let currentDayString: String = DayCollectionView.daySringArr[indexPath.row % 7]
            if currentDayString == "토" {
                cell.dayLabel.textColor = .systemBlue
            } else if currentDayString == "일" {
                cell.dayLabel.textColor = .systemPink
            }
            
            if indexPath.row < collectionView.startIndex || indexPath.row > collectionView.endIndex {
                cell.isCurrentMonth = false
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MonthCalendarViewController: UICollectionViewDelegate {
    
}

extension MonthCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀의 사이즈 정의
        return CGSize(width: collectionView.frame.width / 7, height: MonthCalendarCollectionViewCell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 셀 간 세로간격 조정
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 셀 간 가로간격 조정
        return 0
    }
}
