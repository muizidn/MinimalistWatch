//
//  Clock.swift
//  Minimalist Watch
//
//  Created by Muhammad Muizzsuddin on 01/08/23.
//

import SwiftUI

struct Clock: View {
    @State var currentDate = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        ZStack {
            BackgroundAnimation(color_1: .purple, color_2: .purple, color_3: .purple)
            VStack {
                VStack {
                    Text(getDate())
                    HStack {
                        Text(getHour())
                        Spacer()
                        Text(":")
                        Spacer()
                        Text(getMinute())
                        Spacer()
                        Text(":")
                        Spacer()
                        Text(getSecond())
                    }
                    .font(.system(size: 50, weight: .heavy))
                    .lineLimit(1)
                    HStack {
                        Spacer()
                        Text(getAmPm())
                            .font(.system(size: 30))
                    }
                }
                .padding()
            }
            .padding()
        }
        .onReceive(timer) { input in
            currentDate = input
        }
    }
    
    let dateFormatter = DateFormatter()
    
    func getDate() -> String {
        dateFormatter.dateFormat = "dd MMM YYYY"
        return dateFormatter.string(from: currentDate)
    }
    
    func getHour() -> String {
        dateFormatter.dateFormat = "hh"
        return dateFormatter.string(from: currentDate)
    }
    
    func getMinute() -> String {
        dateFormatter.dateFormat = "mm"
        return dateFormatter.string(from: currentDate)
    }
    
    func getSecond() -> String {
        dateFormatter.dateFormat = "ss"
        return dateFormatter.string(from: currentDate)
    }
    
    func getAmPm() -> String {
        dateFormatter.dateFormat = "a"
        return dateFormatter.string(from: currentDate)
    }
}

struct Clock_Previews: PreviewProvider {
    static var previews: some View {
        Clock()
    }
}
