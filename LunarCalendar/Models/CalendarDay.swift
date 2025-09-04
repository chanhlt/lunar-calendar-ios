//
//  CalendarDay.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//
import Foundation

let thienCan = [
    "Giáp", "Ất", "Bính", "Đinh", "Mậu",
    "Kỷ", "Canh", "Tân", "Nhâm", "Quý"
]

let diaChi = [
    "Tý", "Sửu", "Dần", "Mão", "Thìn", "Tỵ",
    "Ngọ", "Mùi", "Thân", "Dậu", "Tuất", "Hợi"
]


struct CalendarDay: Identifiable, Hashable {
    var id: Date { date }   // unique per day
    let date: Date
    let lunar: LunarDate
    let gregorianDay: Int
    let lunarDay: String
    let isToday: Bool
    let isHoliday: Bool
}

let lunarDB = LunarDatabase()


extension LunarDate {
    func formatted() -> String {
        let dayStr = lunarDayStr()
        let monthStr = lunarMonthStr()
        let year = lunarYearName()
        return "\(dayStr) \(monthStr), \(year)"
    }
    
    func lunarYearName() -> String {
        let can = thienCan[(lunarYear + 6) % 10]   // offset so 1984 = Giáp Tý
        let chi = diaChi[(lunarYear + 8) % 12]
        return "\(can) \(chi)"
    }
    
    func lunarDayStr() -> String {
        if lunarDay == 15 {
            return "rằm"
        }
        let dayPrefix = lunarDay <= 10 ? "mùng " : ""
        return "\(dayPrefix)\(lunarDay)"
    }
    
    func lunarMonthStr() -> String {
        let monthText = isLeapMonth
            ? "\(lunarMonth) (nhuận)"
            : "\(lunarMonth)"
        let monthStr: String
            switch lunarMonth {
            case 1:  monthStr = "tháng Giêng"
            case 12: monthStr = "tháng Chạp"
            default: monthStr = "tháng \(monthText)"
            }
        return monthStr
    }

}

extension CalendarDay {
    
    func isInMonth(_ month: CalendarDay) -> Bool {
        return Calendar.current.isDate(month.date, equalTo: date, toGranularity: .month)
    }
    
    func isSameDate(_ other: CalendarDay) -> Bool {
        return Calendar.current.isDate(date, inSameDayAs: other.date)
    }
    
    func lunarFormatted() -> String {
        return lunar.formatted()
    }
    
    func solarFormatted() -> String {
        return date.formatted(date: .long, time: .omitted)
    }
    
    func toHoliday() -> (String, String)? {
        let _holiday = holiday(for: date)
        if _holiday == nil {
            return nil
        }
        return (name: _holiday!.name, formatted: _holiday!.solarDate != nil ? date.formatted(date: .long, time: .omitted) : lunar.formatted())
    }
}

extension Date {
    func lunarFormatted() -> String {
        let lunar = lunarDB?.query(for: self)
        return lunar?.formatted() ?? ""
    }
    
    func toLunar() -> LunarDate? {
        return lunarDB?.query(for: self)
    }
}

extension Calendar {
    
    func lunarDay(for date: Date = Date()) -> CalendarDay {
        let lunar = date.toLunar()!
        let lunarDay = lunar.lunarDay
        var lunarDayStr = "\(lunarDay)"
        if lunarDay == 1 {
            let lunarMonth = lunar.lunarMonth
            lunarDayStr = "\(lunarDay)/\(lunarMonth)"
        }
     
        return CalendarDay(
            date: date,
            lunar: lunar,
            gregorianDay: component(.day, from: date),
            lunarDay: lunarDayStr,
            isToday: isDateInToday(date),
            isHoliday: holiday(for: date) != nil
        )
    }
    
    func weekDays(for date: Date) -> [CalendarDay] {
        let startOfWeek = self.startOfWeek(for: date)
        return (0..<7).map { offset in
            let d = self.date(byAdding: .day, value: offset, to: startOfWeek)!
            return self.lunarDay(for: d)
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
            days.append(self.lunarDay(for: current))
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
