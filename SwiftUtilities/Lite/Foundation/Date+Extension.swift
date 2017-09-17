//
//  Date+Extension.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension Date {
    
    public init?(string: String, format: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        guard let date = dateFormatter.date(from: string) else {
            return nil
        }
        
        self = date
    }
    
    public func format(_ format: String, locale: String? = nil) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        if let localeString = locale {
            formatter.locale = Locale(identifier: localeString)
        }
        
        return formatter.string(from: self)
    }
    
    public func components() -> DateComponents {
        return (Calendar.current as NSCalendar).components([
            .era,
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second,
            .weekday,
            .weekdayOrdinal,
            .quarter,
            .weekOfMonth,
            .weekOfYear,
            .yearForWeekOfYear,
            .nanosecond,
            .calendar,
            .timeZone
        ], from: self)
    }
    
    public func dayOfYear() -> Int {
        return (Calendar.current as NSCalendar).ordinality(of: .day, in: .year, for: self)
    }
    
}

public func localizeFormat(_ format: String) -> String {
    return DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: Locale.current)!
}
