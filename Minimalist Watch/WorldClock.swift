//
//  WorldClock.swift
//  Minimalist Watch
//
//  Created by Muhammad Muizzsuddin on 01/08/23.
//

import SwiftUI
import MapKit

struct WorldClock: View {
    @State var searchCity = ""
    var body: some View {
        ZStack {
            BackgroundAnimation(color_1: .green, color_2: .green, color_3: .green)
            VStack {
                ScrollView {
                    LazyVStack {
                        HStack {
                            WorldClockCard()
                            WorldClockCard()
                        }
                        HStack {
                            WorldClockCard()
                            WorldClockCard()
                        }
                        HStack {
                            WorldClockCard()
                            WorldClockCard()
                        }
                        HStack {
                            WorldClockCard()
                            WorldClockCard()
                        }
                    }
                }
                Button("Add Clock") {
                    
                }
                .font(.largeTitle)
            }
            .padding()
        }
    }
}

struct WorldClockCard: View {
    @State var currentDate = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Tokyo")
                .font(.system(size: 50, weight: .heavy))
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
        .background(Color.blue.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 12))
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

struct MapView: View {
    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
    }

    private let tokyoCoordinates = CLLocationCoordinate2D(latitude: 35.682839, longitude: 139.759455)
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.682839, longitude: 139.759455), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
}

struct WorldClock_Previews: PreviewProvider {
    static var previews: some View {
        WorldClock()
    }
}
