//
//  SingleTon.swift
//  WepleMoneyClone
//
//  Created by kakao on 2021/01/09.
//

import Foundation

class SingleTon {
    static let shared: SingleTon = SingleTon()
    
    var selectedDate: Date?
    
    private init() {}
}
