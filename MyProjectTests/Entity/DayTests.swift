//
//  DayTests.swift
//  MyProjectTests
//
//  Created by Anastasiia Chechina on 06.05.2022.
//

import XCTest
@testable import MyProject

// MARK: - Tests for Day class

final class DayTests: XCTestCase {

    // MARK: - Private Properties

    private let dateService: IDateService = DateService()

    func testInitDay() {
        let date = Date()
        var day = Day(id: UUID().uuidString, startTime: date, endTime: dateService.nextDay(for: date))

        let record = Record(
            starTime: date,
            endTime: dateService.nextDay(for: date),
            name: "Ann",
            surname: "Che")

        day.records.push(record)

        let dao = DayDAO(from: day)
        XCTAssertEqual(day.interval.startTime, dao.startTime, "Dao creation failed")
        XCTAssertEqual(day.interval.endTime, dao.endTime, "Dao creation failed")
        XCTAssertEqual(day.id, dao._id, "Dao creation failed")
        XCTAssertEqual(day.records.count, dao.records.count, "Dao creation failed")
        XCTAssertEqual(1, dao.records.count, "Day creation failed")
        
        let newDay = Day(from: dao)

        XCTAssertEqual(day.interval.startTime, newDay.interval.startTime, "Day creation failed")
        XCTAssertEqual(day.interval.endTime, newDay.interval.endTime, "Day creation failed")
        XCTAssertEqual(day.id, newDay.id, "Day creation failed")
        XCTAssertEqual(day.records.count, newDay.records.count, "Day creation failed")
        XCTAssertEqual(1, newDay.records.count, "Day creation failed")

        guard let newRecord = newDay.records.head else { return }
        XCTAssertEqual(record.interval.startTime, newRecord.data.interval.startTime, "Record in day creation failed")
        XCTAssertEqual(record.interval.endTime, newRecord.data.interval.endTime, "Record in day creation failed")
        XCTAssertEqual(record.name, newRecord.data.name, "Record in day creation failed")
        XCTAssertEqual(record.surname, newRecord.data.surname, "Record in day creation failed")
    }
}
