//
//  WeekdayHeaderView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//
import SwiftUI

struct WeekdayHeaderView: View {
    var body: some View {
        HStack {
            ForEach(0..<7, id: \.self) { index in
                Text(shortWeekday(for: index))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    private func shortWeekday(for index: Int) -> String {
        let symbols = Calendar.current.shortWeekdaySymbols
        let first = Calendar.current.firstWeekday - 1 // 0-based
        return symbols[(index + first) % 7]
    }
}
