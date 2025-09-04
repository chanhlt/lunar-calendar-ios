//
//  MainView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 3/9/25.
//

import SwiftUI

struct MainView: View {
    
    @Binding var currentDate: CalendarDay
    @Binding var currentMonth: CalendarDay
    
    var body: some View {
        CalenedarView(currentDate: $currentDate, currentMonth: $currentMonth, onNavigate: changeMonth, formatTitle: monthYearString) {
            let days = Calendar.current.monthDays(for: currentMonth.date)
            MonthView(days: days, currentDate: $currentDate, currentMonth: $currentMonth)
        }
        Spacer()
    }
    
    
    private func changeMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: currentMonth.date) {
            currentMonth = Calendar.current.lunarDay(for: newMonth)
        }
    }
    
    private func monthYearString(for date: CalendarDay) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date.date)
    }
}


#Preview {
    let currentDate = Calendar.current.lunarDay()
    let currentMonth = Calendar.current.lunarDay()
    MainView(currentDate: .constant(currentDate), currentMonth: .constant(currentMonth))
}
