//
//  Date+CurrentDate.swift
//
//  Copyright © 2010 Ruslan Popesku. All rights reserved.
//

import Foundation

extension Date {
    
    func rawDateInToday() -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = calendar.dateComponents([.hour, .minute], from: self)
        let timeFrameDate = calendar.date(
            bySettingHour: dateComponents.hour!,
            minute: dateComponents.minute!,
            second: 0,
            of: Date()
            ) ?? Date()
        
        return timeFrameDate
    }
    
}
