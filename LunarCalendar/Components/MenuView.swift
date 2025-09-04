//
//  BottomTabBar.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

enum MenuMode {
    case home
    case month
}

struct MenuView: View {
    var mode: MenuMode
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
    MenuView(
        mode: .home,
        onHome: { print("Home tapped") },
        onMonth: { print("Month tapped") },
        onToday: { print("Today tapped") },
        onSettings: { print("Settings tapped") }
    )
}
