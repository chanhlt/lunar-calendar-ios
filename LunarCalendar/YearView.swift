//
//  YearView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 8/9/25.
//

import SwiftUI

struct YearView: View {
    @Binding var currentDate: CalendarDay
    var onToday: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    let calendar = Calendar.current
    
    
    private var months: [Date] {
        let year = Calendar.current.dateComponents([.year], from: currentDate.solar)
        return (1...12).compactMap { month -> Date? in
            let comps = DateComponents(year: year.year!, month: month, day: 1)
            return calendar.date(from: comps)
        }
    }
    
    private var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 16), count: 3)
    }
    
    var body: some View {
        CalendarView(
            currentDate: .constant(currentDate),
            onNavigate: changeYear,
            formatTitle: yearFormatted,
            onSwipeLeft: nextYear,
            onSwipeRight: prevYear,
            onSwipeDown: { dismiss() }
        ) {
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(months, id: \.self) { month in
                    MonthGrid(month: month)
                        .onTapGesture {
                            currentDate = Calendar.current.lunarDay(for: month)
                            dismiss()
                        }
                }
            }
            .padding()
        }
        
        Spacer()
        
        // Bottom Navigation
        MenuView(
            mode: .home,
            onHome: { dismiss() },
            onToday: onToday,
            onSettings: { }
        )
    }
    
    private func nextYear() {
        // swipe left → next year
        let next = Calendar.current.date(byAdding: .year, value: 1, to: currentDate.solar)!
        currentDate = Calendar.current.lunarDay(for: next)
    }
    
    private func prevYear() {
        // swipe right → previous year
        let prev = Calendar.current.date(byAdding: .year, value: -1, to: currentDate.solar)!
        currentDate = Calendar.current.lunarDay(for: prev)
    }
    
    private func changeYear(by value: Int) {
        if let newYear = Calendar.current.date(byAdding: .year, value: value, to: currentDate.solar) {
            currentDate = Calendar.current.lunarDay(for: newYear)
        }
    }
    
    private func yearFormatted(_ date: CalendarDay) -> String {
        let comps = Calendar.current.dateComponents([.year], from: currentDate.solar)
        return "\(comps.year!)"
    }
}



#Preview {
    let currentDate = Calendar.current.lunarDay()
    YearView(currentDate: .constant(currentDate), onToday: {})
}
