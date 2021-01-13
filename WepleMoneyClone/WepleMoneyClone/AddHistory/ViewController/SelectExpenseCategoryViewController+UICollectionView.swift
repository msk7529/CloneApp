//
//  SelectExpenseCategoryViewController+UICollectionView.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/12.
//

import Foundation
import UIKit

extension SelectExpenseCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ExpenseCategory.category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpenseCategoryCollectionViewCell.identifier, for: indexPath) as? ExpenseCategoryCollectionViewCell else {
                return UICollectionViewCell()
        }
        cell.category = ExpenseCategory.category[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ExpenseCategoryCollectionViewCell {
            let category: String = cell.category
            
            if let selectExpensePaymentVC = self.storyboard?.instantiateViewController(identifier: "SelectExpensePaymentViewController") as? SelectExpensePaymentViewController {
                let transition: CATransition = CATransition()
                transition.type = CATransitionType.push
                transition.duration = 0.3
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                view.window!.layer.add(transition, forKey: kCATransition)
                
                dataModel?.category = category
                dataModel?.info = InfoTextFiled.text ?? ""
                
                selectExpensePaymentVC.modalPresentationStyle = .fullScreen
                selectExpensePaymentVC.dataModel = dataModel
                
                self.present(selectExpensePaymentVC, animated: false, completion: nil)
            }
        }
    }
}

extension SelectExpenseCategoryViewController: UICollectionViewDelegateFlowLayout {
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
        return 5
    }
}

