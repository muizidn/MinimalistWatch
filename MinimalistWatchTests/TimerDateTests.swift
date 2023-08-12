//
//  TimerDateTests.swift
//  MinimalistWatchTests
//
//  Created by Muhammad Muizzsuddin on 13/08/23.
//

import XCTest
@testable import Minimalist_Watch

final class TimerDateTests: XCTestCase {
    
    func testZeroInput() {
        let intArray = [0, 0, 0]
        let timer = TimerDate(intArray)
        XCTAssertEqual(timer.hour, 0)
        XCTAssertEqual(timer.minute, 0)
        XCTAssertEqual(timer.second, 0)
    }
    
    func testInputSecondOnly() {
        let intArray = [0, 0, 5]
        let timer = TimerDate(intArray)
        XCTAssertEqual(timer.hour, 0)
        XCTAssertEqual(timer.minute, 0)
        XCTAssertEqual(timer.second, 5)
    }
    
    func testInputMinuteOnly() {
        let intArray = [3, 0, 0]
        let timer = TimerDate(intArray)
        XCTAssertEqual(timer.hour, 0)
        XCTAssertEqual(timer.minute, 3)
        XCTAssertEqual(timer.second, 0)
    }
    
    func testInputHourOnly() {
        let intArray = [2, 0, 0, 0, 0]
        let timer = TimerDate(intArray)
        XCTAssertEqual(timer.hour, 2)
        XCTAssertEqual(timer.minute, 0)
        XCTAssertEqual(timer.second, 0)
    }
    
    func testInputMinuteSecond() {
        let intArray = [1,2, 1, 2]
        let timer = TimerDate(intArray)
        XCTAssertEqual(timer.hour, 0)
        XCTAssertEqual(timer.minute, 12)
        XCTAssertEqual(timer.second, 12)
    }
    
    func testInputHourMinute() {
        let intArray = [1,0, 4,5, 0, 0]
        let timer = TimerDate(intArray)
        XCTAssertEqual(timer.hour, 10)
        XCTAssertEqual(timer.minute, 45)
        XCTAssertEqual(timer.second, 0)
    }
    
    func testInputHourSecond() {
        let intArray = [3, 0, 0,0 , 1, 5]
        let timer = TimerDate(intArray)
        XCTAssertEqual(timer.hour, 30)
        XCTAssertEqual(timer.minute, 0)
        XCTAssertEqual(timer.second, 15)
    }
    
    func testInputHourMinuteSecond() {
        let intArray = [4, 2,0, 3,5]
        let timer = TimerDate(intArray)
        XCTAssertEqual(timer.hour, 4)
        XCTAssertEqual(timer.minute, 20)
        XCTAssertEqual(timer.second, 35)
    }
    
    func testInputExcessiveValues_will_not_adjust() {
        let intArray = [9,4, 9,0, 7,0] // Will be adjusted to 00:59:59
        let timer = TimerDate(intArray)
        XCTAssertEqual(timer.hour, 94)
        XCTAssertEqual(timer.minute, 90)
        XCTAssertEqual(timer.second, 70)
    }
    
    func testInputNegativeValues_will_not_adjust() {
        let intArray = [-1,0, -5,0, -1,0] // Will be adjusted to 00:00:00
        let timer = TimerDate(intArray)
        XCTAssertEqual(timer.hour, -10)
        XCTAssertEqual(timer.minute, -50)
        XCTAssertEqual(timer.second, -10)
    }
    
    func testInitialTime() {
        var timer = TimerDate(hour: 1, minute: 1, second: 30)
        XCTAssertEqual(timer.hour, 1)
        XCTAssertEqual(timer.minute, 1)
        XCTAssertEqual(timer.second, 30)
    }
    
    func testReduceBy30Seconds() {
        var timer = TimerDate(hour: 1, minute: 1, second: 30)
        timer.reduce(30)
        XCTAssertEqual(timer.hour, 1)
        XCTAssertEqual(timer.minute, 1)
        XCTAssertEqual(timer.second, 0)
    }
    
    func testReduceByAnother30Seconds() {
        var timer = TimerDate(hour: 1, minute: 1, second: 30)
        timer.reduce(30)
        timer.reduce(30)
        XCTAssertEqual(timer.hour, 1)
        XCTAssertEqual(timer.minute, 0)
        XCTAssertEqual(timer.second, 30)
    }
    
    func testReduceBy30Minutes() {
        var timer = TimerDate(hour: 1, minute: 1, second: 30)
        timer.reduce(30)
        timer.reduce(30)
        timer.reduce(30 * 60)
        XCTAssertEqual(timer.hour, 0)
        XCTAssertEqual(timer.minute, 30)
        XCTAssertEqual(timer.second, 30)
    }
    
    func testAddOneMinute() {
        var timer = TimerDate(hour: 1, minute: 1, second: 30)
        timer.addOneMinute()
        XCTAssertEqual(timer.hour, 1)
        XCTAssertEqual(timer.minute, 2)
        XCTAssertEqual(timer.second, 30)
    }
    
    func testAddOneMinuteWrapToHour() {
        var timer = TimerDate(hour: 1, minute: 59, second: 30)
        timer.addOneMinute()
        XCTAssertEqual(timer.hour, 2)
        XCTAssertEqual(timer.minute, 0)
        XCTAssertEqual(timer.second, 30)
    }
    
}
