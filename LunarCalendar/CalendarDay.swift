//
//  CalendarDay.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//
import Foundation

struct CalendarDay: Identifiable {
    var id: Date { date }   // unique per day
    let date: Date
    let gregorianDay: Int
    let lunarDay: String
    let isToday: Bool
    let isInCurrentMonth: Bool
}


extension Calendar {
    func monthDays(for date: Date) -> [CalendarDay] {
        guard let monthInterval = self.dateInterval(of: .month, for: date),
              let monthFirstWeek = self.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = self.dateInterval(of: .weekOfMonth, for: monthInterval.end.addingTimeInterval(-1))
        else { return [] }
        
        // Full range: from first week’s Sunday → last week’s Saturday
        let fullRange = monthFirstWeek.start...monthLastWeek.end
        
        var days: [CalendarDay] = []
        var current = fullRange.lowerBound
        
        while current <= fullRange.upperBound {
            let day = component(.day, from: current)
            let isToday = isDateInToday(current)
            let inMonth = isDate(current, equalTo: date, toGranularity: .month)
            
            days.append(CalendarDay(
                date: current,
                gregorianDay: day,
                lunarDay: "TODO",  // replace later with lunar calculation
                isToday: isToday,
                isInCurrentMonth: inMonth
            ))
            
            current = self.date(byAdding: .day, value: 1, to: current)!
        }
        
        return days
    }
}
