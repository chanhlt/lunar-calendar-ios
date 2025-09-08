//
//  BottomTabBar.swift
//  LunarCalendar
//
//  Created by Chanh Le on 29/8/25.
//

import SwiftUI

enum MenuMode {
    case home
    case year
}

struct MenuView: View {
    var mode: MenuMode
    var onHome: (() -> Void)? = nil
    var onYear: (() -> Void)? = nil
    var onToday: () -> Void
    var onSettings: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Spacer()
            
            if mode == .year {
                Button(action: { onYear?() }) {
                    VStack {
                        Image(systemName: "calendar")
                        Text("year")
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
            
            Button(action: { onSettings?() }) {
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
        mode: .year,
        onToday: { print("Today tapped") }
    )
}
