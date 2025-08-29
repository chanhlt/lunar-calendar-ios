//
//  MonthView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct MonthView: View {
    @State private var currentMonth: Date = Date()
    
    var body: some View {
        VStack {
            
            // Header
            HStack {
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Spacer()
                
                Text(monthYearString(for: currentMonth))
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
            
            Divider()
            
            // Calendar Grid
            CalendarGridView() // reuse your custom component
            
            Divider()
            
            // Day details (optional section)
            VStack(spacing: 8) {
                Text("Selected: Aug 29, 2025")
                    .font(.headline)
                Text("Lunar: 7th Month, 26th Day")
                    .font(.subheadline)
                HStack {
                    Image(systemName: "moon.stars.fill")
                    Text("Moon Phase: Waning Gibbous")
                }
                .font(.subheadline)
            }
            .padding()
            
            Spacer()
        }
    }
    
    // Helpers
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
