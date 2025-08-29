//
//  CalendarGridView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct CalendarGridView: View {
    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    // Example data model for a day
    struct CalendarDay: Identifiable {
        let id = UUID()
        let gregorianDay: Int
        let lunarDay: String
        let isToday: Bool
    }
    
    // Example dataset for demo purposes
    let monthDays: [[CalendarDay]] = [
        // Each array = a week
        [
            CalendarDay(gregorianDay: 27, lunarDay: "23", isToday: false),
            CalendarDay(gregorianDay: 28, lunarDay: "24", isToday: false),
            CalendarDay(gregorianDay: 29, lunarDay: "25", isToday: true),
            CalendarDay(gregorianDay: 30, lunarDay: "26", isToday: false),
            CalendarDay(gregorianDay: 31, lunarDay: "27", isToday: false),
            CalendarDay(gregorianDay: 1,  lunarDay: "1", isToday: false),
            CalendarDay(gregorianDay: 2,  lunarDay: "2", isToday: false)
        ],
        // More weeks go here...
    ]
    
    var body: some View {
        VStack {
            // Days of the week header
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 5)
            
            // Calendar grid
            ForEach(Array(monthDays.enumerated()), id: \.offset) { _, week in
                HStack {
                    ForEach(week) { day in
                        VStack {
                            Text("\(day.gregorianDay)")
                                .font(.headline)
                                .foregroundColor(day.isToday ? .white : .primary)
                            Text(day.lunarDay)
                                .font(.caption2)
                            .foregroundColor(day.isToday ? .white : .secondary)
                        }
                        .frame(maxWidth: .infinity, minHeight: 50)
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
}
