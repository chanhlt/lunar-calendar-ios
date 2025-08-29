//
//  CalendarDay.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//
import Foundation

struct CalendarDay: Identifiable, Hashable {
    var id: Date { date }   // unique per day
    let date: Date
    let gregorianDay: Int
    let lunarDay: String
    let isToday: Bool
    let isInCurrentMonth: Bool
}


extension Calendar {
    func weekDays(for date: Date) -> [CalendarDay] {
            guard let weekInterval = self.dateInterval(of: .weekOfMonth, for: date) else { return [] }
            
            var days: [CalendarDay] = []
            var current = weekInterval.start
            
            while current < weekInterval.end {
                let day = component(.day, from: current)
                let isToday = isDateInToday(current)
                let inMonth = isDate(current, equalTo: date, toGranularity: .month)
                
                days.append(CalendarDay(
                    date: current,
                    gregorianDay: day,
                    lunarDay: "11", // plug in lunar logic later
                    isToday: isToday,
                    isInCurrentMonth: inMonth
                ))
                
                current = self.date(byAdding: .day, value: 1, to: current)!
            }
            
            return days
        }
    
    func monthDays(for date: Date) -> [CalendarDay] {
        guard let monthInterval = self.dateInterval(of: .month, for: date),
              let monthFirstWeek = self.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = self.dateInterval(of: .weekOfMonth, for: monthInterval.end.addingTimeInterval(-1))
        else { return [] }
        
        // Correct end: subtract 1 day because `end` is exclusive
        let lastVisibleDay = self.date(byAdding: .day, value: -1, to: monthLastWeek.end)!
        let fullRange = monthFirstWeek.start...lastVisibleDay
        
        var days: [CalendarDay] = []
        var current = fullRange.lowerBound
        
        while current <= fullRange.upperBound {
            let day = component(.day, from: current)
            let isToday = isDateInToday(current)
            let inMonth = isDate(current, equalTo: date, toGranularity: .month)
            
            days.append(CalendarDay(
                date: current,
                gregorianDay: day,
                lunarDay: "11",  // replace later with lunar calculation
                isToday: isToday,
                isInCurrentMonth: inMonth
            ))
            
            current = self.date(byAdding: .day, value: 1, to: current)!
        }
        
        return days
    }
    
    func weekNumber(for date: Date) -> Int {
        return self.component(.weekOfYear, from: date)
    }
    
    func startOfWeek(for date: Date) -> Date {
        let comps = dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        return self.date(from: comps)!
    }

}
