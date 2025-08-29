//
//  WeekRowView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//
import SwiftUI

struct WeekRowView: View {
    let week: [CalendarDay]
    
    var body: some View {
        HStack {
            if let firstDay = week.first {
                let weekNum = Calendar.current.component(.weekOfYear, from: firstDay.date)
                Text("\(weekNum)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(width: 30, alignment: .trailing)
            }
            
            ForEach(week) { day in
                DayCellView(day: day)
            }
        }
    }
}


#Preview {
    // Example: generate 7 days starting from today
    let weekDays = Calendar.current.weekDays(for: Date())
    WeekRowView(week: weekDays)
}
