//
//  Stopwatch.swift
//  Minimalist Watch
//
//  Created by Muhammad Muizzsuddin on 01/08/23.
//

import SwiftUI

struct Stopwatch: View {
    @State var currentDate = Date(timeIntervalSince1970: 0)
    let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
    
    @State var laps = [Date]()
    
    @State var isRunning = false
    var body: some View {
        ZStack {
            BackgroundAnimation(color_1: .yellow, color_2: .yellow, color_3: .yellow)
            VStack {
                HStack {
                    Text(getHour())
                    Text(":")
                    Text(getMinute())
                    Text(":")
                    Text(getSecond())
                }
                .font(.system(size: 50, weight: .heavy))
                Text(getMiliSecond())
                    .lineLimit(1)
                Spacer().frame(height: 50)
                
                if !laps.isEmpty {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(laps, id: \.timeIntervalSince1970) { lap in
                                LapRow(lap: formatLapTime(lap))
                                    .frame(height: 50)
                            }
                        }
                    }
                    .frame(height: 300)
                }
                
                Spacer().frame(height: 50)
                HStack {
                    Button(!isRunning ? "Start" : "Stop") {
                        isRunning.toggle()
                    }
                    .font(.largeTitle)
                    .padding()
                    if isRunning {
                        Button("Lap") {
                            laps.insert(currentDate, at: 0)
                        }
                        .font(.largeTitle)
                        .padding()
                    }
                }
            }
            .padding()
        }
        .onReceive(timer) { input in
            if isRunning {
                currentDate = currentDate.advanced(by: 0.03)
            }
        }
    }
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.timeZone = .init(secondsFromGMT: 0)
        return df
    }()
    
    func formatLapTime(_ date: Date) -> String {
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        return dateFormatter.string(from: date)
    }
    
    func getHour() -> String {
        dateFormatter.dateFormat = "HH"
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
    
    func getMiliSecond() -> String {
        dateFormatter.dateFormat = "SSS"
        return dateFormatter.string(from: currentDate)
    }
}

struct LapRow: View {
    let lap: String
    
    var body: some View {
        Text(lap)
            .transition(.move(edge: .top))
            .animation(.default)
    }
}



extension Date: Identifiable {
    public var id: String { description }
}


struct Stopwatch_Previews: PreviewProvider {
    static var previews: some View {
        Stopwatch()
    }
}
