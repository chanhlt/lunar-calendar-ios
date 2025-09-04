//
//  WeekRowView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//
import SwiftUI

struct WeekRowView: View {
    let week: [CalendarDay]
    @Binding var currentDate: CalendarDay
    @Binding var currentMonth: CalendarDay
    
    var body: some View {
        HStack {
            if let firstDay = week.first {
                let weekNum = Calendar.current.component(.weekOfYear, from: firstDay.date)
                Text("\(weekNum)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(width: 25, alignment: .trailing)
            }
            
            ForEach(week) { day in
                DayCellView(day: day, currentDate: $currentDate, currentMonth: $currentMonth)
            }
        }
    }
}


#Preview {
    // Example: generate 7 days starting from today
    let weekDays = Calendar.current.weekDays(for: Date())
    let currentDate = Calendar.current.lunarDay(for: Date())
    WeekRowView(week: weekDays, currentDate: .constant(currentDate), currentMonth: .constant(currentDate))
}
