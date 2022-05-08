//
//  DateServiceTests.swift
//  MyProjectTests
//
//  Created by Anastasiia Chechina on 06.05.2022.
//

import XCTest
@testable import MyProject

// MARK: - Tests for DateService class

final class DateServiceTests: XCTestCase {

    // MARK: - Private Properties

    private let dateService: IDateService = DateService()

    private lazy var calendar: Calendar = {
        var calendar = Calendar.current
        calendar.timeZone = .current
        calendar.locale = .current
        return calendar
    }()

    // Test start of day
    func testStartOfday() {
        let day = Date()
        let newDate = dateService.startOfDay(day)
        let components = calendar.dateComponents([.year, .month, .day], from: day)
        let newComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: newDate)

        XCTAssertEqual(components.year, newComponents.year, "Start of day test failed")
        XCTAssertEqual(components.month, newComponents.month, "Start of day test failed")
        XCTAssertEqual(components.day, newComponents.day, "Start of day test failed")
        XCTAssertEqual(0, newComponents.hour, "Start of day test failed")
        XCTAssertEqual(0, newComponents.minute, "Start of day test failed")

    }

    // Test end of day
    func testEndOfday() {
        let day = Date()
        let newDate = dateService.endOfDay(day)
        let components = calendar.dateComponents([.year, .month, .day], from: day)
        let newComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: newDate)

        XCTAssertEqual(components.year, newComponents.year, "Start of day test failed")
        XCTAssertEqual(components.month, newComponents.month, "Start of day test failed")
        XCTAssertEqual(components.day, newComponents.day, "Start of day test failed")
        XCTAssertEqual(23, newComponents.hour, "Start of day test failed")
        XCTAssertEqual(59, newComponents.minute, "Start of day test failed")
    }

    // Test nex day
    func testNexDay() {
        let day = Date()
        let newDate = dateService.nextDay(for: day)
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: day)
        let newComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: newDate)

        XCTAssertEqual(components.year, newComponents.year, "Start of day test failed")
        XCTAssertEqual(components.month, newComponents.month, "Start of day test failed")
        XCTAssertNotEqual(components.day, newComponents.day, "Start of day test failed")
        XCTAssertEqual(0, newComponents.hour, "Start of day test failed")
        XCTAssertEqual(0, newComponents.minute, "Start of day test failed")
    }

    // Test getting free time intervals in period
    func testGetIntervals() {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateFormat = "HH:mm"
        
        let fromStr = "10:00"
        let toStr = "14:00"
        guard
            let from = formatter.date(from: fromStr),
            let to = formatter.date(from: toStr) else { return }
        
        let cleanResult = dateService.intervals(startTime: from, endTime: to, busyIntervals: [])
        XCTAssertEqual(cleanResult.count, 8, "Intervals test failed")


        let fromBusyStr = "11:00"
        let toBusyStr = "11:30"
        guard
            let fromBusy = formatter.date(from: fromBusyStr),
            let toBusy = formatter.date(from: toBusyStr) else { return }
        let busyInterval = Interval(startTime: fromBusy, endTime: toBusy)

        let oneBusyResult = dateService.intervals(startTime: from, endTime: to, busyIntervals: [busyInterval])
        XCTAssertEqual(oneBusyResult.count, 7, "Intervals test failed")
        
        let fromBusyStr1 = "11:45"
        let toBusyStr1 = "11:50"
        guard
            let fromBusy1 = formatter.date(from: fromBusyStr1),
            let toBusy1 = formatter.date(from: toBusyStr1) else { return }
        let busyInterval1 = Interval(startTime: fromBusy1, endTime: toBusy1)

        let twoBusyResult = dateService.intervals(startTime: from, endTime: to, busyIntervals: [busyInterval, busyInterval1])
        XCTAssertEqual(twoBusyResult.count, 8, "Intervals test failed")
    }
}
