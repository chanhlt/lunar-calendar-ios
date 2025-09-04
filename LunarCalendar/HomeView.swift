//
//  ContentView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct HomeView: View {
    @State private var currentDate  = Calendar.current.lunarDay(for: Date())
    @State private var currentMonth  = Calendar.current.lunarDay(for: Date())
    @State private var showDetailView = false
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                MainView(currentDate: $currentDate, currentMonth: $currentMonth)
                
                BottomTabBar(
                    mode: .month,
                    onMonth: { },
                    onToday: {
                        withAnimation {
                            currentDate = Calendar.current.lunarDay()
                            currentMonth = currentDate
                        }
                    },
                    onSettings: { }
                )
                
            }
            .padding()
            
        }
        .simultaneousGesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.height < -50 { // swipe up
                        currentMonth = currentDate
                        showDetailView = true
                    } else if value.translation.width < -50 {
                        withAnimation {
                            // swipe left → next month
                            let next = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth.date)!
                            currentMonth = Calendar.current.lunarDay(for: next)
                        }
                        
                    } else if value.translation.width > 50 {
                        withAnimation {
                            // swipe right → previous month
                            let prev = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth.date)!
                            currentMonth = Calendar.current.lunarDay(for: prev)
                        }
                        
                    }
                }
        )
        .sheet(isPresented: $showDetailView) {
            DetailView(currentDate: $currentDate, currentMonth: $currentMonth)
        }
    }
}


#Preview {
    HomeView()
        .environment(\.locale, .init(identifier: "vi")) // 👈 Vietnamese preview
}
