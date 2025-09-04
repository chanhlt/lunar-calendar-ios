//
//  CalendarView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 4/9/25.
//

import SwiftUI

struct CalenedarView<Content: View>: View {
    
    
    @Binding var currentDate: CalendarDay
    var onNavigate: (_ by: Int) -> Void
    var formatTitle: (_ date: CalendarDay) -> String
    var onSwipeUp: (() -> Void)?
    var onSwipeLeft: (() -> Void)?
    var onSwipeRight: (() -> Void)?
    var onSwipeDown: (() -> Void)?
    
    @ViewBuilder var content: () -> Content
    
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { onNavigate(-1) }) {
                    Image(systemName: "chevron.left")
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                Spacer()
                Text(formatTitle(currentDate))
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: { onNavigate(1) }) {
                    Image(systemName: "chevron.right")
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
            }
            .padding()
            
            Divider()
            
            content()
            
            Spacer()
            
        }
        .contentShape(Rectangle()) // make whole area hittable
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.height < -50 { // swipe up
                        onSwipeUp?()
                    } else if value.translation.width < -50 { // swipe left
                        withAnimation { onSwipeLeft?() }
                    } else if value.translation.width > 50 { // swipe right
                        withAnimation { onSwipeRight?() }
                    } else if value.translation.height > 50 { // swipe down
                        onSwipeDown?()
                    }
                }
        )
    }
    
}


#Preview {
    let currentDate = Calendar.current.lunarDay()
    
    CalenedarView(
        currentDate: .constant(currentDate),
        onNavigate: { offset in
            print("\(offset)")
        },
        formatTitle: { day in
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            return formatter.string(from: day.date)
        }
    ) {
        let days = Calendar.current.monthDays(for: currentDate.date)
        MonthView(days: days, currentDate: .constant(currentDate))
    }
    
    CalenedarView(
        currentDate: .constant(currentDate),
        onNavigate: { offset in
            print("\(offset)")
        },
        formatTitle: { day in
            let week = Calendar.current.dateComponents([.weekOfYear, .year], from: currentDate.date)
            let prefix = String("Week")
            return "\(prefix) \(week.weekOfYear!), \(week.year!)"
        }
    ) {
        let days = Calendar.current.weekDays(for: currentDate.date)
        WeekView(days: days, currentDate: .constant(currentDate))
    }
}
