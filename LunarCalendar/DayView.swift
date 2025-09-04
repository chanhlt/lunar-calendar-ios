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
            
//            // Week container bound to currentDate
//            WeekContainer(currentDate: $currentDate, currentMonth: $currentMonth)
            CalenedarView(currentDate: $currentDate, currentMonth: $currentMonth, onNavigate: changeWeek, formatTitle: formatWeek) {
                let days = Calendar.current.weekDays(for: currentDate.date)
                WeekView(days: days, currentDate: $currentDate, currentMonth: $currentMonth)
            }
            
            if currentDate.isHoliday {
                HolidayView(currentDate: $currentDate)
            }
            
            Spacer()
            
            // Bottom Navigation
            BottomTabBar(
                mode: .month,
                onHome: { dismiss() },
                onToday: {
                    withAnimation {
                        currentDate = Calendar.current.lunarDay()
                        currentMonth = currentDate
                    }
                },
                onSettings: { }
            )
        }
        .padding()
        
    }
    
    private func changeWeek(_ by: Int) {
        
    }
    
    private func formatWeek(_ date: CalendarDay) -> String {
        return ""
    }
}


#Preview {
    let currentDate = Calendar.current.lunarDay()
    DayView(currentDate: .constant(currentDate), currentMonth: .constant(currentDate))
}
