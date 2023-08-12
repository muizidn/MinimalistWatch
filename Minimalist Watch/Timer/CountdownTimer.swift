//
//  CountdownTimer.swift
//  Minimalist Watch
//
//  Created by Muhammad Muizzsuddin on 01/08/23.
//

import SwiftUI

let second: TimeInterval = 60

enum TimerPreset: Identifiable, Hashable {
    var id: String { description }
    
    case custom(TimerDate)
    case time(TimerDate)
    
    var description: String {
        switch self {
        case .custom:
            return "Custom"
        case .time(let timer):
            return timer.stringRepresentation()
        }
    }
}

extension TimerDate {
    var hourRepresentation: String {
        String(format: "%02d", hour)
    }
    
    var minuteRepresentation: String {
        String(format: "%02d", minute)
    }
    
    var secondRepresentation: String {
        String(format: "%02d", second)
    }
    
    func stringRepresentation() -> String {
        var components: [String] = []
        
        if hour > 0 {
            components.append(hourRepresentation + "h")
        }
        
        if minute > 0 {
            components.append(minuteRepresentation + "m")
        }
        
        if second > 0 {
            components.append(secondRepresentation + "s")
        }
        
        return components.joined(separator: " ")
    }
    
}

struct CountdownTimer: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @ObservedObject var vm = CountdownTimerViewModel()
    var body: some View {
        ZStack {
            BackgroundAnimation(color_1: .red, color_2: .red, color_3: .red)
            VStack {
                if vm.isEditingCustomTimer {
                    CustomCountdownTimer()
                } else {
                    HStack {
                        Text(vm.currentTimer.hourRepresentation)
                        Text("h")
                        Text(vm.currentTimer.minuteRepresentation)
                        Text("m")
                        Text(vm.currentTimer.secondRepresentation)
                        Text("s")
                    }
                    .font(.system(size: 50, weight: .heavy))
                    .lineLimit(1)
                    Spacer().frame(height: 50)
                    Button(!vm.isCountingDown ? "Start" : "Stop") {
                        vm.isCountingDown.toggle()
                    }
                    .font(.largeTitle)
                    if vm.isCountingDown {
                        Button("+1 Minute") {
                            vm.addOneMinute()
                        }
                        .font(.title)
                        .padding()
                    }
                    if !vm.isCountingDown {
                        if case .custom = vm.timerPresets[vm.selectedPreset] {
                            Button(vm.isEditingCustomTimer ? "Done" : "Edit") {
                                vm.isEditingCustomTimer.toggle()
                            }
                            .font(.callout)
                            .padding()
                        }
                        Picker("Select Time", selection: $vm.selectedPreset) {
                            ForEach(vm.timerPresets.indices, id: \.self) { i in
                                Text(vm.timerPresets[i].description).tag(i)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
            }
            .padding()
        }
        .environmentObject(vm)
        .onReceive(timer) { input in
            if vm.isCountingDown {
                vm.dateUpdate()
            }
        }
    }
}

extension Int: Identifiable {
    public var id: String {
        self.description
    }
}

struct CountdownTimer_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTimer()
    }
}
