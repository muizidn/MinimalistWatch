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
                    List {
                        ForEach(laps) { lap in
                            Text(lap.description)
                                .frame(height: 50)
                        }
                    }
                    .background(Color.blue)
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

extension Date: Identifiable {
    public var id: String { description }
}


struct Stopwatch_Previews: PreviewProvider {
    static var previews: some View {
        Stopwatch()
    }
}
