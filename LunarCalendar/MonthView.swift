//
//  MonthView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct MonthView: View {
    @Binding var currentMonth: Date
    @Binding var currentDate: Date
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
            
            CalendarGridView(days: Calendar.current.monthDays(for: currentMonth), currentDate: $currentDate)
            
            Spacer()
            
            BottomTabBar(
                mode: .home,
                onHome: { dismiss() },   // 👈 go back to Home
                onToday: {
                    withAnimation {
                        currentMonth = Date()
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
                                    currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth)!
                                }
                                
                            } else if value.translation.width > 50 {
                                withAnimation {
                                    currentMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth)!
                                }
                                
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
    MonthView(currentMonth: .constant(Date()), currentDate: .constant(Date()))
}
