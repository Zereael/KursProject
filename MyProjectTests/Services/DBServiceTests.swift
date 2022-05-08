//
//  DBServiceTests.swift
//  MyProjectTests
//
//  Created by Anastasiia Chechina on 06.05.2022.
//

import XCTest
@testable import MyProject

// MARK: - Tests for DBService class

final class DBServiceTests: XCTestCase {

    // MARK: - Private Properties

    private let dateService: IDateService = DateService()

    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateFormat = "d.MM.yyyy, HH:mm"
        return formatter
    }()

    private lazy var day: Day = {
        let fromStr = "25.05.2022, 10:00"
        let toStr = "25.05.2022, 14:00"
        
        let from = formatter.date(from: fromStr) ?? Date()
        let to = formatter.date(from: toStr) ?? Date()

        return Day(id: UUID().uuidString, startTime: from, endTime: to)
    }()

    private lazy var record1: Record = {
        let fromBusyStr = "25.05.2022, 11:00"
        let toBusyStr = "25.05.2022, 11:30"

        let fromBusy = formatter.date(from: fromBusyStr) ?? Date()
        let toBusy = formatter.date(from: toBusyStr) ?? Date()

        return Record(starTime: fromBusy, endTime: toBusy, name: "Ann", surname: "Che")
    }()

    private lazy var record2: Record = {
        let fromBusyStr = "25.05.2022, 13:00"
        let toBusyStr = "25.05.2022, 13:30"

        let fromBusy = formatter.date(from: fromBusyStr) ?? Date()
        let toBusy = formatter.date(from: toBusyStr) ?? Date()

        return Record(starTime: fromBusy, endTime: toBusy, name: "Naz", surname: "Xc")
    }()

    private lazy var record3: Record = {
        let fromBusyStr = "25.05.2022, 12:00"
        let toBusyStr = "25.05.2022, 12:30"

        let fromBusy = formatter.date(from: fromBusyStr) ?? Date()
        let toBusy = formatter.date(from: toBusyStr) ?? Date()

        return Record(starTime: fromBusy, endTime: toBusy, name: "Ivan", surname: "Sidorov")
    }()

    func testLoop() {
        //Test writing

        day.records.push(record1)

        let writingResult = DBService.write(day: day)
        XCTAssertTrue(writingResult, "Writing fail")

        // Test reading
        let readDays = DBService.read()
        guard let expectedDay = readDays.first(where: { $0.id == day.id }) else { return }
        XCTAssertEqual(expectedDay.id, day.id, "Reading fail")
        XCTAssertEqual(expectedDay.interval.startTime, day.interval.startTime, "Reading fail")
        XCTAssertEqual(expectedDay.interval.endTime, day.interval.endTime, "Reading fail")
        XCTAssertEqual(expectedDay.records.count, 1, "Reading fail")

        var expectedRecord = expectedDay.records.head
        while expectedRecord != nil {
            XCTAssertEqual(expectedRecord!.data.interval.startTime, record1.interval.startTime, "Reading fail")
            XCTAssertEqual(expectedRecord!.data.interval.endTime, record1.interval.endTime, "Reading fail")
            XCTAssertEqual(expectedRecord!.data.name, record1.name, "Reading fail")
            XCTAssertEqual(expectedRecord!.data.surname, record1.surname, "Reading fail")
            expectedRecord = expectedRecord?.next
        }

        // Test update
        // Second record

        let insertResult = day.records.insert(record2, after: 0)
        XCTAssertTrue(insertResult, "Writing fail")

        let addingResult = DBService.update(day: day)
        XCTAssertTrue(addingResult, "Writing fail")

        // Third Record

        let insertResult2 = day.records.insert(record3, after: 0)
        XCTAssertTrue(insertResult2, "Writing fail")

        let addingResult2 = DBService.update(day: day)
        XCTAssertTrue(addingResult2, "Writing fail")

        // Read day with 3 records
        let readUpdatedDays = DBService.read()
        guard let expectedDay = readUpdatedDays.first(where: { $0.id == day.id }) else { return }
        XCTAssertEqual(expectedDay.id, day.id, "Reading fail")
        XCTAssertEqual(expectedDay.interval.startTime, day.interval.startTime, "Reading fail")
        XCTAssertEqual(expectedDay.interval.endTime, day.interval.endTime, "Reading fail")
        XCTAssertEqual(expectedDay.records.count, 3, "Reading fail")

        var index = 0
        
        expectedRecord = expectedDay.records.head
        while expectedRecord != nil {
            if index == 0 {
                XCTAssertEqual(expectedRecord!.data.interval.startTime, record1.interval.startTime, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.interval.endTime, record1.interval.endTime, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.name, record1.name, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.surname, record1.surname, "Reading fail")
            } else if index == 1 {
                XCTAssertEqual(expectedRecord!.data.interval.startTime, record3.interval.startTime, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.interval.endTime, record3.interval.endTime, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.name, record3.name, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.surname, record3.surname, "Reading fail")
            } else if index == 2 {
                XCTAssertEqual(expectedRecord!.data.interval.startTime, record2.interval.startTime, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.interval.endTime, record2.interval.endTime, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.name, record2.name, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.surname, record2.surname, "Reading fail")
            }
            index += 1
            expectedRecord = expectedRecord?.next
        }

        // Test delete one record
        day.records.remove(at: 1)
        let deleteRecodResult = DBService.update(day: day)
        XCTAssertTrue(deleteRecodResult, "Writing fail")

        // Read day with 2 records
        let readDeletedRecordDays = DBService.read()
        guard let deletedRecordDay = readDeletedRecordDays.first(where: { $0.id == day.id }) else { return }
        XCTAssertEqual(deletedRecordDay.id, day.id, "Reading fail")
        XCTAssertEqual(deletedRecordDay.interval.startTime, day.interval.startTime, "Reading fail")
        XCTAssertEqual(deletedRecordDay.interval.endTime, day.interval.endTime, "Reading fail")
        XCTAssertEqual(deletedRecordDay.records.count, 2, "Reading fail")

        index = 0
        
        expectedRecord = deletedRecordDay.records.head
        while expectedRecord != nil {
            if index == 0 {
                XCTAssertEqual(expectedRecord!.data.interval.startTime, record1.interval.startTime, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.interval.endTime, record1.interval.endTime, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.name, record1.name, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.surname, record1.surname, "Reading fail")
            } else if index == 1 {
                XCTAssertEqual(expectedRecord!.data.interval.startTime, record2.interval.startTime, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.interval.endTime, record2.interval.endTime, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.name, record2.name, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.surname, record2.surname, "Reading fail")
            }
            index += 1
            expectedRecord = expectedRecord?.next
        }

        // Test delete
        let deleteResult = DBService.delete(day: day)
        XCTAssertTrue(deleteResult, "Delete fail")

        let daysAfterDelete = DBService.read()
        let deletedDay = daysAfterDelete.first(where: { $0.id == day.id })

        XCTAssertNil(deletedDay, "Delete fail")
    }
}
