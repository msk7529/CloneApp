//
//  MonthCalendarCollectionView.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/04.
//

import Foundation
import UIKit

final class MonthCalendarCollectionView: UICollectionView {
    var dayArr: [Int] = []  // 캘린더상 노출되는 날짜들의 집합
    var numOfRow: Int = 0   // 캘린더상 노출되는 week의 개수
    var startIndex: Int = 0 // 이번달의 시작 날짜의 index
    var endIndex: Int = 0   // 이번달의 마지막 날짜의 index
    
    var currentYear: Int!
    var currentMonth: Int! {
        didSet {
            dayArr = []
            makeDayArr()
            calculateNumOfRow()
            reloadData()
        }
    }
    var currentDay: Int!
    
    private func makeDayArr() {
        var dateComponents: DateComponents = DateComponents()
        dateComponents.year = currentYear
        dateComponents.month = currentMonth
        dateComponents.day = 1
        dateComponents.timeZone = .current
        
        var calendar: Calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ko")
        
        guard let currentDate = calendar.date(from: dateComponents) else {
            print("Error occured in makeDayArr function")
            return
        }
        
        // 여기에 기입하지 않은 날짜는 1로 초기화가 된다
        let components: DateComponents = calendar.dateComponents([.year, .month], from: currentDate)

        // 이번 달의 시작 날짜를 구한다.
        let startOfCurrentMonth: Date = calendar.date(from: components)!
        
        // 이번 달의 마지막 날짜를 구한다.
        let nextMonth: Date = calendar.date(byAdding: .month, value: +1, to: startOfCurrentMonth)!
        let endOfCurrentMonth: Date = calendar.date(byAdding: .day, value: -1, to:nextMonth)!
        
        // 이전 달의 마지막 날짜를 구한다.
        let beforeMonth: Date = calendar.date(byAdding: .day, value: -1, to: startOfCurrentMonth)!
        
        let currentMonthStartDateComponents: DateComponents = calendar.dateComponents([.day,.weekday,.weekOfMonth], from: startOfCurrentMonth)
        let currentMonthEndDateComponents: DateComponents = calendar.dateComponents([.day,.weekday,.weekOfMonth], from: endOfCurrentMonth)
        let beforeMonthEndDateComponents: DateComponents = calendar.dateComponents([.day,.weekday,.weekOfMonth], from: beforeMonth)
        
        let weekArr: [String] = calendar.shortWeekdaySymbols
        var currentMonthStartDay: String = ""
        var currentMonthEndDay: String = ""
        

        // 이번 달의 시작요일과 마지막요일을 구한다.
        if let startDay = currentMonthStartDateComponents.weekday, let endDay = currentMonthEndDateComponents.weekday {
            currentMonthStartDay = weekArr[startDay-1]
            currentMonthEndDay = weekArr[endDay-1]
        }
        
        // 캘린더상에 비활성화 노출될 이전달의 날들을 배열에 추가한다.
        if let index = DayCollectionView.daySringArr.firstIndex(of: currentMonthStartDay) {
            let beforeMonthEndDay: Int = beforeMonthEndDateComponents.day!
            for i in 0..<index {
                dayArr.append(beforeMonthEndDay - index + i + 1)
            }
        }
        
        // 이번달의 날들을 배열에 추가한다.
        for day in currentMonthStartDateComponents.day!...currentMonthEndDateComponents.day! {
            dayArr.append(day)
        }
                
        // 캘린더상에 비활성화 노출될 다음달의 날들을 배열에 추가한다.
        if let index = DayCollectionView.daySringArr.firstIndex(of: currentMonthEndDay) {
            for i in 0..<6-index {
                dayArr.append(1 + i)
            }
        }
        
        // 이번 달의 시작날짜, 마지막날짜의 index를 계산한다.
        calculateStartEndIndexs(startDay: currentMonthStartDateComponents.day!, endDay: currentMonthEndDateComponents.day!)
    }
    
    private func calculateNumOfRow() {
        numOfRow = Int(dayArr.count / 7)
    }

    private func calculateStartEndIndexs(startDay: Int, endDay: Int) {
        if let index = dayArr.firstIndex(of: startDay) {
            startIndex = index
        }
        if let index = dayArr.lastIndex(of: endDay) {
            endIndex = index
        }
    }
}
