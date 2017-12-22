//
//  NSDateExtension.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 22/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//

import Foundation

extension Date {
    func lastMonth() -> String {
        let lastWeek = (Calendar.current as NSCalendar).date(byAdding: .month, value: -1, to: Date(), options: NSCalendar.Options())
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: lastWeek!)
    }
    
    func daysFrom(_ date: Date) -> Int {
        let components = (Calendar.current as NSCalendar).components(NSCalendar.Unit.day, from: date, to: self, options: NSCalendar.Options())
        return components.day!
    }
}
