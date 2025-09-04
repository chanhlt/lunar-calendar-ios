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
            Image(systemName: "fireworks")
                .font(.largeTitle)
                .foregroundColor(.red)
            VStack(alignment: .leading) {
                let (name, formatted) = currentDate.toHoliday() ?? ("Unknown", "Unknown")
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
    let nationalDay = Calendar.current.lunarDay(for: Calendar.current.date(from: DateComponents(
        year: 2025,
        month: 9,
        day: 2
    ))!)
    HolidayView(currentDate: .constant(nationalDay))
}
