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
            HStack {
                Text("Wk")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(width: 30, alignment: .trailing)
                
                WeekdayHeaderView()
            }
            
            // Week row using WeekRowView
            WeekRowView(week: days, currentDate: $currentDate)
        }
    }
}


#Preview {
    // Example: generate 7 days starting from today
    let weekDays = Calendar.current.weekDays(for: Date())
    WeekView(days: weekDays, currentDate: .constant(Calendar.current.lunarDay(for: Date())))
}
