//
//  CalendarGridView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct CalendarGridView: View {
    let days: [CalendarDay]
    
    var body: some View {
        VStack(spacing: 8) {
            // Header row
            HStack {
                Text("Wk")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(width: 30, alignment: .trailing)
                
                WeekdayHeaderView()
            }
            
            // Weeks
            ForEach(weeks(from: days), id: \.self) { week in
                WeekRowView(week: week)
            }
        }
    }
    
    private func weeks(from days: [CalendarDay]) -> [[CalendarDay]] {
        stride(from: 0, to: days.count, by: 7).map {
            Array(days[$0 ..< min($0 + 7, days.count)])
        }
    }
}
