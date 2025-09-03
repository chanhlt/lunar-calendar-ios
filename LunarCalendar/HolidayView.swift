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
                Text(currentDate.date.formatted(date: .long, time: .omitted))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(currentDate.holidayName ?? "Unknown")
                    .font(.headline)
            }
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemBackground)))
    }
    
}

#Preview {
    let today = Calendar.current.lunarDay(for: Date())
    let yesterday = Calendar.current.lunarDay(for: Calendar.current.date(byAdding: .day, value: -1, to: today.date)!)
    HolidayView(currentDate: .constant(yesterday))
}
