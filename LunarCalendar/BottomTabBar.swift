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
                        Text("month")
                    }
                }
            } else {
                Button(action: { onHome?() }) {
                    VStack {
                        Image(systemName: "house")
                        Text("home")
                    }
                }
            }
            
            Spacer()
            
            Button(action: onToday) {
                VStack {
                    Image(systemName: "clock")
                    Text("today")
                }
            }
            
            Spacer()
            
            Button(action: onSettings) {
                VStack {
                    Image(systemName: "gearshape")
                    Text("settings")
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    BottomTabBar(
        mode: .home,
        onHome: { print("Home tapped") },
        onMonth: { print("Month tapped") },
        onToday: { print("Today tapped") },
        onSettings: { print("Settings tapped") }
    )
}
