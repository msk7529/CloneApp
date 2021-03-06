//
//  IncomeDAO.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/14.
//

import UIKit
import CoreData

final class IncomeDAO {
    lazy var context: NSManagedObjectContext = {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    func fetch(yearMonth: String) -> [IncomeInfoModel] {
        var IncomeInfoList: [IncomeInfoModel] = []

        let fetchRequest: NSFetchRequest<IncomeInfo> = IncomeInfo.fetchRequest()   // 요청 객체 생성. fetchRequest 메서드는 NSManagedObject와 IncomeInfo 클래스에서 각각 정의되있고 이들은 오버라이드 관계가 아니어서 서로 다른 타입을 반환하게 된다. 따라서 타입 어노테이션을 누락하면 컴파일 에러가 발생
        let regdateDesc: NSSortDescriptor = NSSortDescriptor(key: "createAt", ascending: false)  // 최신 내역 순으로 정렬하도록 정렬 객체 생성
        fetchRequest.sortDescriptors = [regdateDesc]

        if !yearMonth.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "yearMonth == %@", yearMonth)
        } else {
            print("Error! fetch string is empty.")
            return IncomeInfoList
        }

        do {
            // 읽어온 결과 집합을 순회하면서 [IncomeInfoModel] 타입으로 변환한다.
            let resultset: [IncomeInfo] = try self.context.fetch(fetchRequest)

            for record in resultset {
                // IncomeInfoModel 객체를 생성한다.
                let model: IncomeInfoModel = IncomeInfoModel()
                model.category = record.category
                model.createAt = record.createAt
                model.date = record.date
                model.info = record.info
                model.objectID = record.objectID
                model.price = record.price
                model.repeatCycle = record.repeatCycle
                model.yearMonth = record.yearMonth
                
                // 이미지가 있을 때만 복사
                if let image = record.photo as Data? {
                    model.photo = UIImage(data: image)
                }
                
                IncomeInfoList.append(model)
            }
        } catch let error as NSError {
            NSLog("An error has occured : %s", error.localizedDescription)
        }
        return IncomeInfoList
    }
    
    func fetchAtCertainDate(date: Date) -> [IncomeInfoModel] {
        var IncomeInfoList: [IncomeInfoModel] = []

        let fetchRequest: NSFetchRequest<IncomeInfo> = IncomeInfo.fetchRequest()   // 요청 객체 생성. fetchRequest 메서드는 NSManagedObject와 IncomeInfo 클래스에서 각각 정의되있고 이들은 오버라이드 관계가 아니어서 서로 다른 타입을 반환하게 된다. 따라서 타입 어노테이션을 누락하면 컴파일 에러가 발생
        let regdateDesc: NSSortDescriptor = NSSortDescriptor(key: "createAt", ascending: false)  // 최신 내역 순으로 정렬하도록 정렬 객체 생성
        fetchRequest.sortDescriptors = [regdateDesc]
        fetchRequest.predicate = NSPredicate(format: "date == %@", date as CVarArg)

        do {
            // 읽어온 결과 집합을 순회하면서 [IncomeInfoModel] 타입으로 변환한다.
            let resultset: [IncomeInfo] = try self.context.fetch(fetchRequest)

            for record in resultset {
                // IncomeInfoModel 객체를 생성한다.
                let model: IncomeInfoModel = IncomeInfoModel()
                model.category = record.category
                model.createAt = record.createAt
                model.date = record.date
                model.info = record.info
                model.objectID = record.objectID
                model.price = record.price
                model.repeatCycle = record.repeatCycle
                model.yearMonth = record.yearMonth
                
                // 이미지가 있을 때만 복사
                if let image = record.photo as Data? {
                    model.photo = UIImage(data: image)
                }
                
                IncomeInfoList.append(model)
            }
        } catch let error as NSError {
            NSLog("An error has occured : %s", error.localizedDescription)
        }
        return IncomeInfoList
    }
    
    func saveHistory(_ data: IncomeInfoModel) {
        let object: IncomeInfo = NSEntityDescription.insertNewObject(forEntityName: "IncomeInfo", into: self.context) as! IncomeInfo  // 관리 객체 인스턴스 생성
        
        // IncomeInfoModel로 부터 값을 복사한다.
        object.category = data.category
        object.createAt = Date()
        object.date = data.date
        object.info = data.info
        object.memo = data.memo ?? ""
        object.price = data.price ?? 0
        object.yearMonth = data.yearMonth ?? "0"
        object.repeatCycle = data.repeatCycle ?? ""
        
        if let image = data.photo {
            object.photo = image.pngData()!
        }
        
        // 영구저장소에 변경사항을 반영한다.
        do {
            try self.context.save()
        } catch let error as NSError {
            NSLog("An error has occured : %s", error.localizedDescription)
        }
    }
    
    func delete(_ objectID: NSManagedObjectID) -> Bool {
        // 삭제할 객체를 찾아, 컨텍스트에서 삭제한다.
        let object: NSManagedObject = self.context.object(with: objectID)
        self.context.delete(object)

        do {
            // 삭제한 내역을 영구저장소에 반환한다.
            try self.context.save()
            return true
        } catch let error as NSError {
            NSLog("An error has occured : %s", error.localizedDescription)
            return false
        }
    }
}
