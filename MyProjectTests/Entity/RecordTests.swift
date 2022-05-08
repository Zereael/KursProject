//
//  RecordTests.swift
//  MyProjectTests
//
//  Created by Anastasiia Chechina on 06.05.2022.
//

import XCTest
@testable import MyProject

// MARK: - Tests for Record class

final class RecordTests: XCTestCase {

    // MARK: - Private Properties

    private let dateService: IDateService = DateService()

    func testInitRecord() {
        let date = Date()
        let record = Record(
            starTime: date,
            endTime: dateService.nextDay(for: date),
            name: "Ann",
            surname: "Che")

        let dao = RecordDAO(from: record)
        
        let newRecord = Record(from: dao)

        XCTAssertEqual(record.interval.startTime, newRecord.interval.startTime, "Record creation failed")
        XCTAssertEqual(record.interval.endTime, newRecord.interval.endTime, "Record creation failed")
        XCTAssertEqual(record.name, newRecord.name, "Record creation failed")
        XCTAssertEqual(record.surname, newRecord.surname, "Record creation failed")
    }
}
