//
//  MonthGrid.swift
//  LunarCalendar
//
//  Created by Chanh Le on 8/9/25.
//

import SwiftUI

struct MonthGrid: View {
    let month: Date
    
    
    init(month: Date) {
        self.month = month
    }
    
    
    private var calendar = Calendar.current
    
    private var days: [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: month),
              let start = calendar.date(from: calendar.dateComponents([.year, .month], from: month)) else {
            return []
        }
        return range.compactMap { day -> Date? in
            calendar.date(byAdding: .day, value: day - 1, to: start)
        }
    }
    
    private var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 1), count: 7) // 7 days in week
    }
    
    var body: some View {
        VStack {
            Text(month, formatter: monthFormatter)
                .font(.caption)
                .bold()
                .foregroundColor(isCurrentMonth(month) ? .red : .primary)
            
            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(days, id: \.self) { day in
                    let calendarDay = calendar.lunarDay(for: day)
                    let isBusy = calendarDay.isHoliday
                    let isSpecial = calendarDay.isSpecialDay
                    
                    Rectangle()
                        .fill(
                            isBusy ? Color.red :
                            isSpecial ? Color.orange :
                            Color.gray.opacity(0.2)
                        )
                        .frame(height: 10)
                        .cornerRadius(2)
                }
            }
        }
        .padding(8)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 1)
    }
}

private func isCurrentMonth(_ month: Date) -> Bool {
    let current = Calendar.current.lunarDay().solar
    return Calendar.current.isDate(month, equalTo: current, toGranularity: .month)
}


private let monthFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "MMM YYYY"
    return df
}()

#Preview {
    let calendar = Calendar.current
    let currentDate = calendar.lunarDay()
    let comps = DateComponents(year: 2025, month: 9, day: 1)
    let month = calendar.date(from: comps)
    MonthGrid(month: month!)
}
