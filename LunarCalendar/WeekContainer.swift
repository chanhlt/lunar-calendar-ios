//
//  HomeWeekContainer.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct WeekContainer: View {
    @Binding var currentDate: CalendarDay
    @Binding var currentMonth: CalendarDay
    
    var body: some View {
        VStack {
            // Controls
            HStack {
                Button(action: { changeWeek(by: -1) }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text(weekTitle)
                    .font(.headline)
                Spacer()
                Button(action: { changeWeek(by: 1) }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            let days = Calendar.current.weekDays(for: currentDate.date)
            WeekView(days: days, currentDate: $currentDate, currentMonth: $currentMonth)
                
        }
    }
    
    private var weekTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        let start = Calendar.current.startOfWeek(for: currentDate.date)
        let end = Calendar.current.date(byAdding: .day, value: 6, to: start)!
        return "\(formatter.string(from: start)) – \(formatter.string(from: end))"
    }
    
    private func changeWeek(by offset: Int) {
        if let newDate = Calendar.current.date(byAdding: .weekOfYear, value: offset, to: currentDate.date) {
            currentDate = Calendar.current.lunarDay(for: newDate)
        }
    }
}

#Preview {
    let currentDate = Calendar.current.lunarDay(for: Date())
    WeekContainer(currentDate: .constant(currentDate), currentMonth: .constant(currentDate))
}
