//
//  ContentView.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

struct HomeView: View {
    @State private var currentDate  = Calendar.current.lunarDay(for: Date())
    @State private var showDetailView = false
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                MainView(
                    currentDate: $currentDate,
                    onSwipeUp: showDayView,
                    onSwipeLeft: nextMonth,
                    onSwipeRight: prevMonth
                )
                
                MenuView(
                    mode: .month,
                    onMonth: { },
                    onToday: { withAnimation { onToday() } },
                    onSettings: { }
                )
                
            }
            .padding()
            
        }
        .contentShape(Rectangle())
        .sheet(isPresented: $showDetailView) {
            DetailView(
                currentDate: $currentDate,
                onToday: { withAnimation { onToday() } },
                nextWeek: nextWeek,
                prevWeek: prevWeek
            )
        }
    }
    
    private func showDayView() {
        showDetailView = true
    }
    
    private func nextMonth() {
        // swipe left → next month
        let next = Calendar.current.date(byAdding: .month, value: 1, to: currentDate.date)!
        currentDate = Calendar.current.lunarDay(for: next)
    }
    
    private func prevMonth() {
        // swipe right → previous month
        let prev = Calendar.current.date(byAdding: .month, value: -1, to: currentDate.date)!
        currentDate = Calendar.current.lunarDay(for: prev)
    }
    
    private func nextWeek() {
        // swipe left → next week
        let next = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate.date)!
        currentDate = Calendar.current.lunarDay(for: next)
    }
    
    private func prevWeek() {
        // swipe right → previous week
        let prev = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate.date)!
        currentDate = Calendar.current.lunarDay(for: prev)
    }
    
    private func onToday() {
        currentDate = Calendar.current.lunarDay()
    }
}


#Preview {
    HomeView()
}
