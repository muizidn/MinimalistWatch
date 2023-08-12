//
//  TimerDate.swift
//  Minimalist Watch
//
//  Created by Muhammad Muizzsuddin on 13/08/23.
//

import Foundation

struct TimerDate: Hashable {
    private(set) var hour: Int
    private(set) var minute: Int
    private(set) var second: Int
    
    init(_ intArray: [Int]) {
        let zeroPad = [0, 0, 0, 0, 0, 0]
        
        let paddedInput = Array((zeroPad + intArray).suffix(6))
        
        hour = paddedInput[0] * 10 + paddedInput[1]
        minute = paddedInput[2] * 10 + paddedInput[3]
        second = paddedInput[4] * 10 + paddedInput[5]
    }
    
    init(hour: Int, minute: Int, second: Int) {
        self.hour = hour
        self.minute = minute
        self.second = second
    }
    
    mutating func reduce(_ unit: Int = 1) {
        if second >= unit {
            second -= unit
        } else {
            let secondsToBorrow = (unit - second) % 60
            second = 60 - secondsToBorrow
            reduceMinutes((unit - second) / 60 + 1)
        }
    }
    
    mutating func addOneMinute() {
        if minute >= 59 {
            minute = 0
            addOneHour()
        } else {
            minute += 1
        }
    }
    
    mutating private func addOneHour() {
        hour = hour + 1
    }
    
    mutating private func reduceMinutes(_ unit: Int) {
        if minute >= unit {
            minute -= unit
        } else {
            let minutesToBorrow = (unit - minute) % 60
            minute = 60 - minutesToBorrow
            reduceHours((unit - minute) / 60 + 1)
        }
    }
    
    mutating private func reduceHours(_ unit: Int) {
        if hour >= unit {
            hour -= unit
        } else {
            hour = 0 // TimerDate reached 00:00:00
            minute = 0
            second = 0
        }
    }
    
    static let zero: TimerDate = .init([])
}
