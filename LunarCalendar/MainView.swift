//
//  MainView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 3/9/25.
//

import SwiftUI

struct MainView: View {
    
    @Binding var currentDate: CalendarDay
    var onSwipeUp: (() -> Void)?
    
    var body: some View {
        CalenedarView(
            currentDate: $currentDate,
            onNavigate: changeMonth,
            formatTitle: monthYearString,
            onSwipeUp: onSwipeUp,
            onSwipeLeft: { withAnimation { nextMonth() } },
            onSwipeRight: { withAnimation { prevMonth() } }
        ) {
            let days = Calendar.current.monthDays(for: currentDate.date)
            MonthView(days: days, currentDate: $currentDate)
        }
        Spacer()
    }
    
    
    private func changeMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: currentDate.date) {
            currentDate = Calendar.current.lunarDay(for: newMonth)
        }
    }
    
    private func monthYearString(for date: CalendarDay) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date.date)
    }
    
    
    private func nextMonth() {
        // swipe left → next month
        let next = Calendar.current.date(byAdding: .month, value: 1, to: currentDate.date)!
        currentDate = Calendar.current.lunarDay(for: next)
    }
    
    private func prevMonth() {
        // swipe right → previous month
        let prev = Calendar.current.date(byAdding: .month, value: -1, to: currentDate.date)!
        currentDate = Calendar.current.lunarDay(for: prev)
    }
}


#Preview {
    let currentDate = Calendar.current.lunarDay()
    MainView(currentDate: .constant(currentDate))
}
