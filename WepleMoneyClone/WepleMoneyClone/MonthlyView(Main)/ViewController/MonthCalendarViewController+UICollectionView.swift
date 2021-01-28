//
//  MonthCalendarViewController+UICollectionView.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/04.
//
import UIKit

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
            
            let isUnActiveCell: Bool = indexPath.row < collectionView.startIndex || indexPath.row > collectionView.endIndex
            if isUnActiveCell {
                cell.isCurrentMonth = false     // 비활성화되는 셀
            }
            
            let currentDayString: String = DayCollectionView.daySringArr[indexPath.row % 7]
            cell.currentDayString = currentDayString    // 셀에 해당하는 요일
            
            let dayNum: Int = collectionView.dayArr[indexPath.row]
            let dayString: String = String(format: "%02d", dayNum)  // 셀의 날짜
            if let todayDay = currentDay, todayDay == dayNum && !isUnActiveCell {
                cell.isToday = true
            } else {
                cell.isToday = false
            }
            cell.dayLabel.text = String(dayNum)
            
            var currentDate: Date
            if indexPath.row < collectionView.startIndex {
                if currentMonth == 1 {
                    currentDate = dateformatter.date(from: "\(currentYear! - 1) 12 \(dayString)") ?? Date()
                } else {
                    currentDate = dateformatter.date(from: "\(currentYear!) \(currentMonth! - 1) \(dayString)") ?? Date()
                }
            } else if indexPath.row > collectionView.endIndex {
                if currentMonth == 12 {
                    currentDate = dateformatter.date(from: "\(currentYear! + 1) 1 \(dayString)") ?? Date()
                } else {
                    currentDate = dateformatter.date(from: "\(currentYear!) \(currentMonth! + 1) \(dayString)") ?? Date()
                }
            } else {
                currentDate = dateformatter.date(from: "\(currentYear!) \(currentMonth!) \(dayString)") ?? Date()
            }
            cell.currentDate = currentDate
            
            if let selectedDate = SingleTon.shared.selectedDate {
                if selectedDate == cell.currentDate && isUnActiveCell == false {
                    cell.isSelected = true
                } else {
                    cell.isSelected = false
                }
            }
            
            cell.incomeModel = collectionView.fetchOneDayIncomeInfoModel(date: currentDate)
            cell.expenseModel = collectionView.fetchOneDayExpenseInfoModel(date: currentDate)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let collectionView = collectionView as? MonthCalendarCollectionView else { return }

        if let cell = collectionView.cellForItem(at: indexPath) as? MonthCalendarCollectionViewCell {
            if cell.isCurrentMonth == true {
                self.showDailyHistoryInfo?(cell.expenseModel, cell.incomeModel)
            } else {
                if indexPath.row < collectionView.startIndex {
                    if currentMonth == 1 {
                        self.goPreviousPage?(self.currentYear! - 1, 12)
                    } else {
                        self.goPreviousPage?(self.currentYear!, self.currentMonth! - 1)
                    }
                } else if indexPath.row > collectionView.endIndex {
                    if currentMonth == 12 {
                        self.goNextPage?(self.currentYear! + 1, 1)
                    } else {
                        self.goNextPage?(self.currentYear!, self.currentMonth! + 1)
                    }
                }
            }
        }
        
        collectionView.reloadData()
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
