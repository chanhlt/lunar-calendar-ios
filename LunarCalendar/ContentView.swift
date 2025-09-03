//
//  ContentView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var currentDate  = Calendar.current.lunarDay(for: Date())
    @State private var showMonthView = false
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // Header with today’s date
                VStack {
                    Text(currentDate.date.formatted(date: .long, time: .omitted))
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text(currentDate.date.lunarFormatted())
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                
                // Week container bound to currentDate
                HomeWeekContainer(currentDate: $currentDate)
                
                if currentDate.isHoliday {
                    HolidayView(currentDate: $currentDate)
                }
                
                Spacer()
                
                // Bottom Navigation
                BottomTabBar(
                    mode: .month,
                    onMonth: { showMonthView = true },
                    onToday: {
                        withAnimation {
                            currentDate = Calendar.current.lunarDay(for: Date())
                        }
                    },
                    onSettings: { showSettings = true }
                )
            }
            .padding()
            
        }
        .simultaneousGesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.height < -50 { // swipe up
                        showMonthView = true
                    } else if value.translation.width < -50 {
                        withAnimation {
                            // swipe left → next week
                            let next = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate.date)!
                            currentDate = Calendar.current.lunarDay(for: next)
                        }
                        
                    } else if value.translation.width > 50 {
                        withAnimation {
                            // swipe right → previous week
                            let prev = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate.date)!
                            currentDate = Calendar.current.lunarDay(for: prev)
                        }
                        
                    }
                }
        )
        .sheet(isPresented: $showMonthView) {
            MonthView(currentMonth: $currentDate, currentDate: $currentDate)
        }
    }
}


#Preview {
    ContentView()
        .environment(\.locale, .init(identifier: "vi")) // 👈 Vietnamese preview
}
