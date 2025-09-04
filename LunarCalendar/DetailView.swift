//
//  DetailView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 3/9/25.
//
import SwiftUI

struct DetailView: View {
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
            
            // Week container bound to currentDate
            WeekContainer(currentDate: $currentDate, currentMonth: $currentMonth)
            
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
//        .contentShape(Rectangle())
//        .simultaneousGesture(
//            DragGesture()
//                .onEnded { value in
//                    if value.translation.width < -50 {
//                        withAnimation {
//                            let next = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentMonth.date)!
//                            currentMonth = Calendar.current.lunarDay(for: next)
//                        }
//                        
//                    } else if value.translation.width > 50 {
//                        withAnimation {
//                            let prev = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentMonth.date)!
//                            currentMonth = Calendar.current.lunarDay(for: prev)
//                        }
//                        
//                    }
//                }
//        )
//        
        
    }
}


#Preview {
    let currentDate = Calendar.current.lunarDay()
    DetailView(currentDate: .constant(currentDate), currentMonth: .constant(currentDate))
}
