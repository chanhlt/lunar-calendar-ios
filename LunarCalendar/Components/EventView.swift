//
//  HolidayView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 3/9/25.
//


import SwiftUI

struct EventView: View {
    @Binding var currentDate: CalendarDay
    var event: Event
    
    var body: some View {
        HStack {
            Image(systemName: "newspaper.circle")
                .font(.largeTitle)
                .foregroundColor(.yellow)
            VStack(alignment: .leading) {
                Text(formmated())
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(event.name)
                    .font(.headline)
            }
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemBackground)))
    }
    
    private func formmated() -> String {
        if event.isAllDay {
            if event.solarDay != nil && event.solarMonth != nil {
                return currentDate.solar.formatted(date: .long, time: .omitted)
            }
            if event.lunarDay != nil && event.lunarMonth != nil {
                return currentDate.lunar.formatted()
            }
        }
        
        if event.startHour != nil && event.endHour != nil {
            let startHour = String(format: "%02d", event.startHour ?? 0)
            let startMinute = String(format: "%02d", event.startMinute ?? 0)
            let endHour = String(format: "%02d", event.endHour ?? 0)
            let endMinute = String(format: "%02d", event.endMinute ?? 0)
            return "\(startHour):\(startMinute) - \(endHour):\(endMinute)"
        }
        
        return "Unknown"
    }
    
}

#Preview {
    let date = Calendar.current.lunarDay(
        for: Calendar.current.date(from: DateComponents(year: 2025, month: 7, day: 22))!
    )
    var event = Event(
        id: 1,
        name: "Sinh Nhật Vợ",
        solarDay: 22,
        solarMonth: 7,
        lunarDay: nil,
        lunarMonth: nil,
        startHour: nil,
        startMinute: nil,
        endHour: nil,
        endMinute: nil,
        isAllDay: true
    )
    EventView(currentDate: .constant(date), event: event)
    
    
    let date2 = Calendar.current.lunarDay(
        for: Calendar.current.date(from: DateComponents(year: 2025, month: 9, day: 12))!
    )
    let event2 = Event(
        id: 1,
        name: "PV ABC",
        solarDay: 12,
        solarMonth: 9,
        lunarDay: nil,
        lunarMonth: nil,
        startHour: 9,
        startMinute: 30,
        endHour: 10,
        endMinute: 30,
        isAllDay: false
    )
    EventView(currentDate: .constant(date2), event: event2)
}
