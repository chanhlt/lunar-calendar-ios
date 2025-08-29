//
//  MonthView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct MonthView: View {
    @Binding var currentMonth: Date
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text(monthYearString(for: currentMonth))
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding()
            
            Divider()
            
            CalendarGridView(days: Calendar.current.monthDays(for: currentMonth))
            
            Spacer()
            
            BottomTabBar(
                mode: .home,
                onHome: { dismiss() },   // 👈 go back to Home
                onToday: { currentMonth = Date() },
                onSettings: { /* show settings */ }
            )

        }
        .padding()
        .background(
            Color.clear
                .contentShape(Rectangle())
                .simultaneousGesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < -50 {
                                currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth)!
                            } else if value.translation.width > 50 {
                                currentMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth)!
                            }
                        }
                )
        )
    }
    
    private func changeMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }
    
    private func monthYearString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}



#Preview {
    MonthView(currentMonth: .constant(Date()))
}
