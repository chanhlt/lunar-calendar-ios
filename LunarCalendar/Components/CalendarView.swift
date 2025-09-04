//
//  CalendarView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 4/9/25.
//

import SwiftUI

struct CalenedarView<Content: View>: View {
    
    
    @Binding var currentDate: CalendarDay
    @Binding var currentMonth: CalendarDay
    var onNavigate: (_ by: Int) -> Void
    var formatTitle: (_ date: CalendarDay) -> String
    
    @ViewBuilder var content: () -> Content
    
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { onNavigate(-1) }) {
                    Image(systemName: "chevron.left")
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                Spacer()
                Text(formatTitle(currentMonth))
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: { onNavigate(1) }) {
                    Image(systemName: "chevron.right")
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
            }
            .padding()
            
            Divider()
            
            content()
            
        }
    }
    
}


#Preview {
    let currentDate = Calendar.current.lunarDay()
    let currentMonth = Calendar.current.lunarDay()
    
    CalenedarView(currentDate: .constant(currentDate), currentMonth: .constant(currentMonth), onNavigate: {by in
        print("\(by)")
    }, formatTitle: {value in
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: value.date)
    }) {
        let days = Calendar.current.monthDays(for: currentMonth.date)
        MonthView(days: days, currentDate: .constant(currentDate), currentMonth: .constant(currentMonth))
    }
}
