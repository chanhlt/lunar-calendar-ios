//
//  CalendarGridView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct MonthView: View {
    let days: [CalendarDay]
    @Binding var currentDate: CalendarDay
    
    var body: some View {
        VStack(spacing: 8) {
            // Header row
            WeekdayHeaderView()
            
            // Weeks
            ForEach(weeks(from: days), id: \.self) { week in
                WeekRowView(week: week, currentDate: $currentDate)
            }
        }
    }
    
    private func weeks(from days: [CalendarDay]) -> [[CalendarDay]] {
        stride(from: 0, to: days.count, by: 7).map {
            Array(days[$0 ..< min($0 + 7, days.count)])
        }
    }
}


#Preview {
    let monthDays = Calendar.current.monthDays(for: Date())
    let currentDate = Calendar.current.lunarDay()
    MonthView(days: monthDays, currentDate: .constant(currentDate))
}
