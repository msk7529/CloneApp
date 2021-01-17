//
//  SelectIncomeCategoryViewController+UICollectionView.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/13.
//

import Foundation
import UIKit

extension SelectIncomeCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return IncomeCategory.category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IncomeCategoryCollectionViewCell.identifier, for: indexPath) as? IncomeCategoryCollectionViewCell else {
                return UICollectionViewCell()
        }
        cell.category = IncomeCategory.category[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? IncomeCategoryCollectionViewCell {
            guard let dataModel = dataModel else { return }
            
            dataModel.category = cell.category
            dataModel.info = self.InfoTextFiled.text
            incomeDAO.saveHistory(dataModel)
            
            NotificationCenter.default.post(name: NSNotification.Name("AddHistoryNotification"), object: nil)
            
            self.closeButtonDidTap()
        }
    }
}

extension SelectIncomeCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀의 사이즈 정의
        return CGSize(width: 60, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 셀 간 세로간격 조정
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 셀 간 가로간격 조정
        return 15
    }
}

