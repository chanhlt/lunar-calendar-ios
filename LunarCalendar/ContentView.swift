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
                    Text("Lunar: 7th Month, 26th Day")
                        .font(.title2)
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
                    onToday: { currentDate = Date() },
                    onSettings: { showSettings = true }
                )
                .sheet(isPresented: $showMonthView) {
                    MonthView(currentMonth: $currentDate)
                }
            }
            .padding()
        }
    }
}


#Preview {
    ContentView()
}
