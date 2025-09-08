//
//  HolidayView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 3/9/25.
//


import SwiftUI

struct HolidayView: View {
    @Binding var currentDate: CalendarDay
    
    var body: some View {
        HStack {
            Image(systemName: currentDate.isHoliday ? "fireworks" : "party.popper")
                .font(.largeTitle)
                .foregroundColor(currentDate.isHoliday ? .red : .orange)
            VStack(alignment: .leading) {
                let (name, formatted) = (
                    currentDate.isHoliday ? currentDate.toHoliday() : currentDate.toSpecialDay()
                ) ?? ("Unknown", "Unknown")
                Text(formatted)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(name)
                    .font(.headline)
            }
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemBackground)))
    }
    
}

#Preview {
    let currentDate = Calendar.current.lunarDay(
        for: Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 8))!
    )
    HolidayView(currentDate: .constant(currentDate))
}
