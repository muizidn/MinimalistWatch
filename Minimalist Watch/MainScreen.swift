//
//  MainScreen.swift
//  Minimalist Watch
//
//  Created by Muhammad Muizzsuddin on 01/08/23.
//

import SwiftUI

enum Tool: String, Hashable, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case clock = "Clock"
    case timer = "Timer"
    case stopwatch = "Stopwatch"
    case worldClock = "World Clock"
}

struct MainScreen: View {
    @State var selectedTool = Tool.clock
    
    var body: some View {
        TabView {
            Clock()
                .tabItem {
                    Image("clock")
                    Text("Clock")
                }
            CountdownTimer()
                .tabItem {
                    Image("timer")
                    Text("Timer")
                }
            Stopwatch()
                .tabItem {
                    Image("stopwatch")
                    Text("Stopwatch")
                }
            WorldClock()
                .tabItem {
                    Image("world")
                    Text("World")
                }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
