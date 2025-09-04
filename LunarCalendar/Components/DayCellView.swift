//
//  DayCellView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//
import SwiftUI

struct DayCellView: View {
    let day: CalendarDay
    @Binding var currentDate: CalendarDay
    
    var body: some View {
        VStack(spacing: 0) {
            Text("\(day.gregorianDay)")
                .font(.system(size: 20))
                .bold()
                .foregroundColor(
                    day.isToday || day.isSameDate($currentDate.wrappedValue) ? .white :
                        day.isHoliday ? .red :
                        day.isInMonth($currentDate.wrappedValue) ? .primary : .gray)
            
            Text(day.lunarDay)
                .font(.system(size: 10))
                .foregroundColor(
                    day.isToday || day.isSameDate($currentDate.wrappedValue) ? .white :
                        day.isHoliday ? .red :
                        day.isInMonth($currentDate.wrappedValue) ? .primary : .gray)
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .padding(1)
        .contentShape(Rectangle()) // makes full cell tappable
        .highPriorityGesture(
                    TapGesture().onEnded {
                        currentDate = day
                    }
                )
        .background(
            day.isToday ? Circle().fill(Color.blue) :
                day.isSameDate($currentDate.wrappedValue) ? Circle().fill(Color.secondary) :
                Circle().fill(Color.clear)
        )
        
    }
    
}

#Preview {
    let calendar = Calendar.current
    let today = calendar.lunarDay(for: Date(), current: Date())
    let nextDay = calendar.date(byAdding: .day, value: 1, to: Date())
    let tomorrow = calendar.lunarDay(for: nextDay ?? Date(), current: nextDay ?? Date())
    let currentDate = Calendar.current.lunarDay(for: nextDay ?? Date())
    DayCellView(day: tomorrow, currentDate: .constant(currentDate))
    
}
