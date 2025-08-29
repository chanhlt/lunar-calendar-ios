//
//  HomeWeekContainer.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct HomeWeekContainer: View {
    @State private var currentWeekStart = Calendar.current.startOfWeek(for: Date())
    
    var body: some View {
        VStack {
            // Navigation controls
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
            
            // Your existing WeekView
            WeekView(days: daysInWeek(starting: currentWeekStart))
        }
    }
    
    private var weekTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        let end = Calendar.current.date(byAdding: .day, value: 6, to: currentWeekStart)!
        return "\(formatter.string(from: currentWeekStart)) – \(formatter.string(from: end))"
    }
    
    private func changeWeek(by offset: Int) {
        if let newStart = Calendar.current.date(byAdding: .weekOfYear, value: offset, to: currentWeekStart) {
            currentWeekStart = newStart
        }
    }
    
    private func daysInWeek(starting start: Date) -> [CalendarDay] {
        (0..<7).map { offset in
            let date = Calendar.current.date(byAdding: .day, value: offset, to: start)!
            return CalendarDay(
                date: date,
                gregorianDay: Calendar.current.component(.day, from: date),
                lunarDay: "11", // TODO: plug in your lunar logic
                isToday: Calendar.current.isDateInToday(date),
                isInCurrentMonth: Calendar.current.isDate(date, equalTo: Date(), toGranularity: .month)
            )
        }
    }
}
