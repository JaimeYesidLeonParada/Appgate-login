//
//  Date+Helper.swift
//  Date+Helper
//
//  Created by Jaime Yesid Leon Parada on 16/08/21.
//

import Foundation

extension Date {
    func currentTime() -> String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd,yyyy HH:mm"
        
        return formatter.string(from: today)
    }
    
    func currentTime(time: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy HH:mm"
        
        if let date: Date = dateFormatterGet.date(from: time) {
            return dateFormatterPrint.string(from: date)
        } else {
            return currentTime()
        }
    }
}
