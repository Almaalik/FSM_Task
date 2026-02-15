//
//  extension-date.swift
//  FSM
//
//  Created by AlMaalik's Mac on 13/02/26.
//

import Foundation

extension Date {
    func smartFormatted() -> String {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        if calendar.isDateInToday(self) {
            return "Today, \(formatter.string(from: self))"
        } else if calendar.isDateInTomorrow(self) {
            return "Tomorrow, \(formatter.string(from: self))"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday, \(formatter.string(from: self))"
        } else {
            let fullFormatter = DateFormatter()
            fullFormatter.dateFormat = "dd/MM/yyyy, h:mm a"
            return fullFormatter.string(from: self)
        }
    }
}

