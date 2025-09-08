//
//  Holiday.swift
//  LunarCalendar
//
//  Created by Chanh Le on 3/9/25.
//
import Foundation

struct Holiday {
    let name: String
    let solarDate: DateComponents?   // for solar-based holidays
    let lunarDate: (day: Int, month: Int)? // for lunar-based holidays
}

let vietnamHolidays: [Holiday] = [
    Holiday(name: "Tết Dương lịch", solarDate: DateComponents(month: 1, day: 1), lunarDate: nil),
    Holiday(name: "Quốc tế Phụ nữ", solarDate: DateComponents(month: 3, day: 8), lunarDate: nil),
    Holiday(name: "Giải phóng miền Nam", solarDate: DateComponents(month: 4, day: 30), lunarDate: nil),
    Holiday(name: "Quốc tế Lao động", solarDate: DateComponents(month: 5, day: 1), lunarDate: nil),
    Holiday(name: "Quốc khánh", solarDate: DateComponents(month: 9, day: 2), lunarDate: nil),
    Holiday(name: "Phụ nữ Việt Nam", solarDate: DateComponents(month: 10, day: 20), lunarDate: nil),
    Holiday(name: "Nhà giáo Việt Nam", solarDate: DateComponents(month: 11, day: 20), lunarDate: nil),

    Holiday(name: "Mùng 1 Tết", solarDate: nil, lunarDate: (1, 1)),
    Holiday(name: "Mùng 2 Tết", solarDate: nil, lunarDate: (2, 1)),
    Holiday(name: "Mùng 3 Tết", solarDate: nil, lunarDate: (3, 1)),
    Holiday(name: "Giỗ Tổ Hùng Vương", solarDate: nil, lunarDate: (10, 3)),
    Holiday(name: "Tết Trung Thu", solarDate: nil, lunarDate: (15, 8))
]

func holiday(_ solar: Date, _ lunar: LunarDate) -> Holiday? {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day, .month], from: solar)
    
    for holiday in vietnamHolidays {
        if let solarDate = holiday.solarDate,
           solarDate.day == components.day && solarDate.month == components.month {
            return holiday
        }
        
        if let lunarDate = holiday.lunarDate {
            if lunarDate.day == lunar.day && lunarDate.month == lunar.month {
                return holiday
            }
        }
    }
    return nil
}
