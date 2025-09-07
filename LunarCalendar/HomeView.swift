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
            MainView(
                currentDate: $currentDate,
                onSwipeUp: showDayView,
                onToday: onToday
            )
        }
        .contentShape(Rectangle())
        .sheet(isPresented: $showDetailView) {
            DetailView(
                currentDate: $currentDate,
                onToday: onToday
            )
        }
    }
    
    private func showDayView() {
        showDetailView = true
    }
    
    
    private func onToday() {
        currentDate = Calendar.current.lunarDay()
    }
}


#Preview {
    HomeView()
}
