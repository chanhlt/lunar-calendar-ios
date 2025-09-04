//
//  WeekView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct WeekView: View {
    let days: [CalendarDay]
    @Binding var currentDate: CalendarDay
    
    var body: some View {
        VStack(spacing: 8) {
            // Weekday header row
            WeekdayHeaderView()
            
            // Week row using WeekRowView
            WeekRowView(week: days, currentDate: $currentDate)
        }
    }
}


#Preview {
    let weekDays = Calendar.current.weekDays(for: Date())
    let currentDate = Calendar.current.lunarDay(for: Date())
    WeekView(days: weekDays, currentDate: .constant(currentDate))
}
