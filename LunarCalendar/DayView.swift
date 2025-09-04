//
//  DetailView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 3/9/25.
//
import SwiftUI

struct DayView: View {
    @Binding var currentDate: CalendarDay
    @Binding var currentMonth: CalendarDay
    var onToday: () -> Void
    var nextWeek: () -> Void
    var prevWeek: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        // Header with today’s date
        VStack {
            Text(currentDate.solarFormatted())
                .font(.headline)
                .foregroundColor(.gray)
            Text("Âm lịch: \(currentDate.lunarFormatted())")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.vertical, 5)
            
            CalenedarView(
                currentDate: $currentDate,
                currentMonth: $currentMonth,
                onNavigate: changeWeek,
                formatTitle: formatWeek,
                onSwipeLeft: nextWeek,
                onSwipeRight: prevWeek,
                onSwipeDown: { dismiss() }
            ) {
                let days = Calendar.current.weekDays(for: currentMonth.date)
                WeekView(days: days, currentDate: $currentDate, currentMonth: $currentMonth)
                
                if currentDate.isHoliday {
                    HolidayView(currentDate: $currentDate)
                }
                
                Spacer()
            }
            
            
            // Bottom Navigation
            BottomTabBar(
                mode: .home,
                onHome: { dismiss() },
                onToday: onToday,
                onSettings: { }
            )
        }
        .padding()
        .contentShape(Rectangle())
        
    }
    
    private func changeWeek(_ by: Int) {
        if let newDate = Calendar.current.date(byAdding: .weekOfYear, value: by, to: currentMonth.date) {
            currentMonth = Calendar.current.lunarDay(for: newDate)
        }
    }
    
    private func formatWeek(_ date: CalendarDay) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        let start = Calendar.current.startOfWeek(for: date.date)
        let end = Calendar.current.date(byAdding: .day, value: 6, to: start)!
        return "\(formatter.string(from: start)) – \(formatter.string(from: end))"
    }
}


#Preview {
    let currentDate = Calendar.current.lunarDay()
    DayView(
        currentDate: .constant(currentDate),
        currentMonth: .constant(currentDate),
        onToday: { },
        nextWeek: { },
        prevWeek: { }
    )
}
