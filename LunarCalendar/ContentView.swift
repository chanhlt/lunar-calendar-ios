//
//  ContentView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var currentDate: Date = Date()
    @State private var showMonthView = false
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // Header with today’s date
                VStack {
                    Text(currentDate.formatted(date: .long, time: .omitted))
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text(currentDate.lunarFormatted())
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                
                // Week container bound to currentDate
                HomeWeekContainer(currentDate: $currentDate)
                    
                
                // Moon phase / festival highlight
                HStack {
                    Image(systemName: "moon.stars.fill")
                        .font(.largeTitle)
                    VStack(alignment: .leading) {
                        Text("Today's Moon Phase")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Waning Gibbous")
                            .font(.headline)
                    }
                    Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemBackground)))
                
                Spacer()
                
                // Bottom Navigation
                BottomTabBar(
                    mode: .month,
                    onMonth: { showMonthView = true },
                    onToday: {
                        withAnimation {
                            currentDate = Date()
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
                            currentDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate)!
                        }
                        
                    } else if value.translation.width > 50 {
                        withAnimation {
                            // swipe right → previous week
                            currentDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate)!
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
