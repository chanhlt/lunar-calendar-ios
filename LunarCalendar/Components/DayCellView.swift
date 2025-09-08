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
        let textColor = selectTextColor()
        let bgColor = selectBackgroundColor()
        VStack(spacing: 0) {
            Text("\(day.gregorianDay)")
                .font(.system(size: 20))
                .bold()
                .foregroundColor(textColor)
            Text(day.lunarDay)
                .font(.system(size: 10))
                .foregroundColor(textColor)
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .padding(1)
        .contentShape(Rectangle())
        .highPriorityGesture(
                    TapGesture().onEnded {
                        currentDate = day
                    }
                )
        .background(Circle().fill(bgColor))
        
    }
    
    private func selectTextColor() -> Color {
        return day.isToday || day.isSameDate($currentDate.wrappedValue) ? .white :
        day.isHoliday ? .red :
        day.isSpecialDay ? .orange :
        day.isInMonth($currentDate.wrappedValue) ? .primary : .gray
    }
    
    private func selectBackgroundColor() -> Color {
        return day.isToday ? .blue :
        day.isSameDate($currentDate.wrappedValue) ? .secondary :
        .clear
    }
    
}

#Preview {
    let calendar = Calendar.current
    let today = calendar.lunarDay()
    let tomorrow = calendar.lunarDay(for: calendar.date(byAdding: .day, value: 1, to: today.solar)!)
    let nationalDay = calendar.lunarDay(for: calendar.date(from: DateComponents(year: 2025, month: 9, day: 2))!)
    DayCellView(day: today, currentDate: .constant(today))
    DayCellView(day: tomorrow, currentDate: .constant(today))
    DayCellView(day: nationalDay, currentDate: .constant(today))
    DayCellView(day: nationalDay, currentDate: .constant(nationalDay))
}
