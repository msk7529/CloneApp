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