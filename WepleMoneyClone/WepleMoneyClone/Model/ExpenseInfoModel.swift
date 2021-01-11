//
//  ExpenseModel.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/12.
//

import Foundation
import UIKit
import CoreData

class ExpenseInfoModel {
    var date: Date?
    var createAt: Date?
    var price: Int32?
    var info: String?
    var payment: String?
    var memo: String?
    var category: String?
    var repeatCycle: String?
    var photo: UIImage?
    var yearMonth: String?      // 몇년도 몇월의 history인지 판별하기 위한 속성 ex) "202101"
    var objectID: NSManagedObjectID?    // 원본 ExpenseInfo 객체를 참조하기 위한 속성
}
