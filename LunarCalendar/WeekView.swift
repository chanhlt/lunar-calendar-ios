//
//  WeekView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct WeekView: View {
    let days: [CalendarDay]
    
    var body: some View {
        VStack(spacing: 8) {
            // Weekday header row
            HStack {
                Text("Wk") // label for clarity
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(width: 30, alignment: .leading)
                
                WeekdayHeaderView()
            }
            
            // Week row with number
            HStack {
                // Week number
                if let firstDay = days.first {
                    let weekNum = Calendar.current.weekNumber(for: firstDay.date)
                    Text("\(weekNum)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(width: 30, alignment: .leading)
                }
                
                // Days in week
                ForEach(days) { day in
                    VStack(spacing: 4) {
                        Text("\(day.gregorianDay)")
                            .font(.headline)
                            .foregroundColor(day.isToday ? .white :
                                             (day.isInCurrentMonth ? .primary : .gray))
                        
                        Text(day.lunarDay)
                            .font(.caption2)
                            .foregroundColor(day.isToday ? .white : .secondary)
                    }
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .padding(6)
                    .background(
                        day.isToday ?
                        Circle().fill(Color.blue) :
                        Circle().fill(Color.clear)
                    )
                }
            }
        }
    }
}


#Preview {
    // Example: generate 7 days starting from today
    let weekDays = Calendar.current.weekDays(for: Date())
    WeekView(days: weekDays)
}
