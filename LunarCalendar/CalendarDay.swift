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
    let isSelected: Bool
}

let lunarDB = LunarDatabase()



extension Date {
    func lunarFormatted() -> String {
        let lunar = lunarDB?.query(for: self)
        let lunarDay = lunar?.lunarDay ?? 0
        let lunarMonth = lunar?.lunarMonth ?? 0
        let lunarYear = lunar?.lunarYear ?? 0
        return "Lunar: Day: \(lunarDay), Month: \(lunarMonth) (\(lunarYear))"
    }
}

extension Calendar {
    
    func lunarDay(for date: Date, current d: Date) -> CalendarDay {
        let lunar = lunarDB?.query(for: date)
        let lunarDay = lunar?.lunarDay ?? 0
        var lunarDayStr = "\(lunarDay)"
        if lunarDay == 1 {
            let lunarMonth = lunar?.lunarMonth ?? 0
            lunarDayStr = "\(lunarDay)/\(lunarMonth)"
        }
        return CalendarDay(
            date: date,
            gregorianDay: component(.day, from: date),
            lunarDay: lunarDayStr,
            isToday: isDateInToday(date),
            isInCurrentMonth: isDate(d, equalTo: date, toGranularity: .month),
            isSelected: isDate(d, equalTo: date, toGranularity: .day)
        )
    }
    func weekDays(for date: Date) -> [CalendarDay] {
        let startOfWeek = self.startOfWeek(for: date)
        return (0..<7).map { offset in
            let d = self.date(byAdding: .day, value: offset, to: startOfWeek)!
            return self.lunarDay(for: d, current: date)
        }
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
            days.append(self.lunarDay(for: current, current: date))
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
