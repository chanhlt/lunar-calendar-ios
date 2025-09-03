//
//  MonthView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct MonthView: View {
    @Binding var currentMonth: CalendarDay
    @Binding var currentDate: CalendarDay
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                        .frame(width: 44, height: 44) // 👈 minimum tap area
                        .contentShape(Rectangle())    // 👈 ensures full frame is tappable
                }
                Spacer()
                Text(monthYearString(for: currentMonth))
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                        .frame(width: 44, height: 44) // 👈 minimum tap area
                        .contentShape(Rectangle())    // 👈 ensures full frame is tappable
                }
            }
            .padding()
            
            Divider()
            
            CalendarGridView(days: Calendar.current.monthDays(for: currentMonth.date), currentDate: $currentDate)
            
            Spacer()
            
            BottomTabBar(
                mode: .home,
                onHome: { dismiss() },   // 👈 go back to Home
                onToday: {
                    withAnimation {
                        currentMonth = Calendar.current.lunarDay(for: Date())
                    }
                },
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
                                withAnimation{
                                    let next = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth.date)!
                                    currentMonth = Calendar.current.lunarDay(for: next)
                                }
                                
                            } else if value.translation.width > 50 {
                                withAnimation {
                                    let prev = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth.date)!
                                    currentMonth = Calendar.current.lunarDay(for: prev)
                                }
                                
                            }
                        }
                )
        )
    }
    
    private func changeMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: currentMonth.date) {
            currentMonth = Calendar.current.lunarDay(for: newMonth)
        }
    }
    
    private func monthYearString(for date: CalendarDay) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date.date)
    }
}



#Preview {
    let currentDate = Calendar.current.lunarDay(for: Date())
    MonthView(currentMonth: .constant(currentDate), currentDate: .constant(currentDate))
}
