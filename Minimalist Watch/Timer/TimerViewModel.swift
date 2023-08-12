//
//  TimerViewModel.swift
//  Minimalist Watch
//
//  Created by Muhammad Muizzsuddin on 13/08/23.
//

import Foundation
import Combine

final class CountdownTimerViewModel: ObservableObject {
    @Published var currentTimer = TimerDate(hour: 0, minute: 0, second: 10)
    @Published var isCountingDown = false
    @Published var isEditingCustomTimer = false
    private(set) var timerPresets: [TimerPreset] = [
        .custom(TimerDate(hour: 0, minute: 0, second: 0)),
        .time(TimerDate(hour: 0, minute: 0, second: 10)),
        .time(TimerDate(hour: 0, minute: 0, second: 30)),
        .time(TimerDate(hour: 0, minute: 1, second: 0)),
        .time(TimerDate(hour: 0, minute: 3, second: 0)),
        .time(TimerDate(hour: 0, minute: 5, second: 0)),
    ]
    @Published var selectedPreset = 1 {
        didSet {
            switch timerPresets[selectedPreset] {
            case .custom(let timer), .time(let timer):
                currentTimer = timer
            }
            
        }
    }
    
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
        
        let timer = TimerDate.init(customTimerInput)
        if selectedPreset == 0 {
            currentTimer = timer
        }
        timerPresets[0] = .custom(timer)
    }
    
    func deleteLastInput() {
        customTimerInput.insert(0, at: 0)
        customTimerInput.removeLast()
        
        let timer = TimerDate.init(customTimerInput)
        if selectedPreset == 0 {
            currentTimer = timer
        }
        timerPresets[0] = .custom(timer)
    }
}
