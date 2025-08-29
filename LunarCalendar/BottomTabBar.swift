//
//  BottomTabBar.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

enum TabBarMode {
    case home
    case month
}

struct BottomTabBar: View {
    var mode: TabBarMode
    var onHome: (() -> Void)? = nil
    var onMonth: (() -> Void)? = nil
    var onToday: () -> Void
    var onSettings: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            
            if mode == .month {
                Button(action: { onMonth?() }) {
                    VStack {
                        Image(systemName: "calendar")
                        Text("Month")
                    }
                }
            } else {
                Button(action: { onHome?() }) {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
            }
            
            Spacer()
            
            Button(action: onToday) {
                VStack {
                    Image(systemName: "clock")
                    Text("Today")
                }
            }
            
            Spacer()
            
            Button(action: onSettings) {
                VStack {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
            }
            
            Spacer()
        }
        .padding()
    }
}
