//
//  DayCellView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//
import SwiftUI

struct DayCellView: View {
    let day: CalendarDay
    
    var body: some View {
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
