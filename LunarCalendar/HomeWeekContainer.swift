//
//  HomeWeekContainer.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct HomeWeekContainer: View {
    @Binding var currentDate: Date
    
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
            
            WeekView(days: Calendar.current.weekDays(for: currentDate))
        }
    }
    
    private var weekTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        let start = Calendar.current.startOfWeek(for: currentDate)
        let end = Calendar.current.date(byAdding: .day, value: 6, to: start)!
        return "\(formatter.string(from: start)) – \(formatter.string(from: end))"
    }
    
    private func changeWeek(by offset: Int) {
        if let newDate = Calendar.current.date(byAdding: .weekOfYear, value: offset, to: currentDate) {
            currentDate = newDate
        }
    }
}
