//
//  TimerViewModel.swift
//  Minimalist Watch
//
//  Created by Muhammad Muizzsuddin on 13/08/23.
//

import Foundation
import Combine

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
        currentTimer.addOneMinute()
    }
    
    func dateUpdate() {
        currentTimer.reduce()
        finishTimerIfNeeded()
    }
    
    private func finishTimerIfNeeded() {
        let isFinish = currentTimer.hour == 0 && currentTimer.minute == 0 && currentTimer.second == 0
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
