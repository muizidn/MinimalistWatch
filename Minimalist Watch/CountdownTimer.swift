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
    
    case custom(TimeInterval)
    case second(TimeInterval)
    case minute(TimeInterval)
    
    var description: String {
        switch self {
        case .custom:
            return "Custom"
        case .second(let timeInterval):
            return "\(timeInterval) seconds"
        case .minute(let timeInterval):
            return "\(timeInterval) minutes"
        }
    }
    
    var value: TimeInterval {
        switch self {
        case .custom(let timeInterval):
            return timeInterval
        case .second(let timeInterval):
            return timeInterval
        case .minute(let timeInterval):
            return timeInterval * 60
        }
    }
}

final class CountdownTimerViewModel: ObservableObject {
    @Published var selectedPreset = TimerPreset.second(10) {
        didSet {
            currentDate =  .init(timeIntervalSince1970: selectedPreset.value)
        }
    }
    private var currentDate = Date(timeIntervalSince1970: TimerPreset.second(10).value)
    @Published var currentTimer = TimerDate(hour: 0, minute: 0, second: 0)
    @Published var isCountingDown = false
    @Published var isEditingCustomTimer = false
    private(set) var timerPresets: [TimerPreset] = [
        .custom(0),
        .second(10),
        .second(30),
        .minute(1),
        .minute(3),
        .minute(5),
    ]
    
    func addOneMinute() {
        currentDate = currentDate.addingTimeInterval(60)
    }
    
    func dateUpdate() {
        currentDate = currentDate.advanced(by: -1)
        finishTimerIfNeeded()
    }
    
    private func finishTimerIfNeeded() {
        let isFinish = currentDate.timeIntervalSince1970 == 0
        if isFinish {
            isCountingDown = false
        }
    }
    
    
    @Published private(set) var customTimerInput = [0,0,0,0,0,0]
    
    func addCustomTimer(number: Int) {
        customTimerInput.append(number)
        if customTimerInput.count > 6 {
            customTimerInput = Array(customTimerInput.dropFirst())
        }
        
        let timeInterval = convertArrayToTimeInterval(customTimerInput)
        
        selectedPreset = .custom(timeInterval)
        timerPresets[0] = selectedPreset
        
    }
    
    func deleteLastInput() {
        customTimerInput.insert(0, at: 0)
        customTimerInput.removeLast()
        
        let timeInterval = convertArrayToTimeInterval(customTimerInput)
        
        selectedPreset = .custom(timeInterval)
        timerPresets[0] = selectedPreset
    }
    
    func convertArrayToTimeInterval(_ array: [Int]) -> TimeInterval {
        var timeInterval: TimeInterval = 0
        let multiplier: [Int:TimeInterval] = [
            0:10*60*60,
            1:60*60,
            2:10*60,
            3:60,
            4:10,
            5:1,
        ]
        for (i, el) in array.enumerated() {
            timeInterval += TimeInterval(el) * (multiplier[i] ?? 1)
        }
        return timeInterval
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
                        Text(vm.currentTimer.hour.description)
                        Text("h")
                        Text(vm.currentTimer.minute.description)
                        Text("m")
                        Text(vm.currentTimer.second.description)
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
                        if case .custom = vm.selectedPreset {
                            Button(vm.isEditingCustomTimer ? "Done" : "Edit") {
                                vm.isEditingCustomTimer.toggle()
                            }
                            .font(.callout)
                            .padding()
                        }
                        Picker("Select Time", selection: $vm.selectedPreset) {
                            ForEach(vm.timerPresets) { i in
                                Text(i.description).tag(i)
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

struct CustomCountdownTimer: View {
    enum _Button: Identifiable {
        var id: String { description }
        
        case delete
        case done
        case number(Int)
        
        var description: String {
            return "\(self)"
        }
    }
    
    @EnvironmentObject var vm: CountdownTimerViewModel
    let buttons: [[_Button]] = [
        [.number(1), .number(2), .number(3)],
        [.number(4), .number(5), .number(6)],
        [.number(7), .number(8), .number(9)],
        [.done, .number(0), .delete],
    ]
    var body: some View {
        VStack {
            HStack {
                Text(
                    vm.customTimerInput[0].description +
                    vm.customTimerInput[1].description
                )
                Text("h")
                Text(
                    vm.customTimerInput[2].description +
                    vm.customTimerInput[3].description
                )
                Text("m")
                Text(
                    vm.customTimerInput[4].description +
                    vm.customTimerInput[5].description
                )
                Text("s")
            }
            .font(.system(size: 50, weight: .heavy))
            .lineLimit(1)
            Spacer().frame(height: 50)
            VStack(spacing: 20) {
                ForEach(buttons) { btns in
                    HStack(spacing: 20) {
                        ForEach(btns) { button in
                            switch button {
                            case .delete:
                                Button("Delete") {
                                    vm.deleteLastInput()
                                }
                            case .done:
                                Button("Done") {
                                    vm.isEditingCustomTimer.toggle()
                                }
                            case let .number(value):
                                NumberButton(number: value)
                            }
                        }
                        .frame(width: 100, height: 50)
                    }
                }
            }
            .padding()
        }
    }
}

struct NumberButton: View {
    let number: Int
    @EnvironmentObject var vm: CountdownTimerViewModel
    
    var body: some View {
        Button(action: {
            vm.addCustomTimer(number: number)
        }, label: {
            Text("\(number)")
                .font(.title)
                .padding()
        })
    }
}

extension Array: Identifiable where Element: Identifiable {
    public var id: String { map({ "\($0.id)"}).joined() }
}

struct CountdownTimer_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTimer()
    }
}
