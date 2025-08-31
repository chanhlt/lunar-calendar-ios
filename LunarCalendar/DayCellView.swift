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
            day.isSelected ?
            Circle().fill(Color.cyan) :
            Circle().fill(Color.clear)
        )
    }
}

#Preview {
    let calendar = Calendar.current
    let today = calendar.lunarDay(for: Date(), current: Date())
    let nextDay = calendar.date(byAdding: .day, value: 1, to: Date())
    let tomorrow = calendar.lunarDay(for: nextDay ?? Date(), current: nextDay ?? Date())
    DayCellView(day: tomorrow)
    
}
