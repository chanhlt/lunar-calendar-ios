//
//  ContentView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var currentDate: Date = Date()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // Header with today’s date
                VStack {
                    Text("Friday, Aug 29, 2025")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("Lunar: 7th Month, 26th Day")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
                // Only one week
//                WeekView(days: Calendar.current.weekDays(for: currentDate))
                HomeWeekContainer()
                
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
                HStack {
                    Spacer()
                    NavigationLink(destination: MonthView()) {
                        VStack {
                            Image(systemName: "calendar")
                            Text("Month")
                        }
                    }
                    Spacer()
                    Button(action: {}) {
                        VStack {
                            Image(systemName: "clock")
                            Text("Today")
                        }
                    }
                    Spacer()
                    Button(action: {}) {
                        VStack {
                            Image(systemName: "gearshape")
                            Text("Settings")
                        }
                    }
                    Spacer()
                }
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
