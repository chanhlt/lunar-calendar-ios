//
//  DetailView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 3/9/25.
//
import SwiftUI

struct DetailView: View {
    @Binding var currentDate: CalendarDay
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
                onNavigate: changeWeek,
                formatTitle: formatWeek,
                onSwipeLeft: nextWeek,
                onSwipeRight: prevWeek,
                onSwipeDown: { dismiss() }
            ) {
                let days = Calendar.current.weekDays(for: currentDate.date)
                WeekView(days: days, currentDate: $currentDate)
                
                if currentDate.isHoliday {
                    HolidayView(currentDate: $currentDate)
                }
                
                Spacer()
            }
            
            
            // Bottom Navigation
            MenuView(
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
        if let newDate = Calendar.current.date(byAdding: .weekOfYear, value: by, to: currentDate.date) {
            currentDate = Calendar.current.lunarDay(for: newDate)
        }
    }
    
    private func formatWeek(_ date: CalendarDay) -> String {
        let week = Calendar.current.dateComponents([.weekOfYear, .year], from: date.date)
        let prefix = String(localized: "Week")
        return "\(prefix) \(week.weekOfYear!), \(week.year!)"
    }
}


#Preview {
    let currentDate = Calendar.current.lunarDay(
        for: Calendar.current.date(from: DateComponents(year: 2025, month: 9, day: 2))!
    )
    DetailView(
        currentDate: .constant(currentDate),
        onToday: { },
        nextWeek: { },
        prevWeek: { }
    )
}
