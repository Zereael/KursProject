//
//  AddInteractorTests.swift
//  MyProjectTests
//
//  Created by Anastasiia Chechina on 07.05.2022.
//

import XCTest
@testable import MyProject

// MARK: - Tests for AddInteractor class

final class AddInteractorTests: XCTestCase {

    // MARK: - Private Properties
    
    private let interactor = AddInteractor()

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

    // Test add functions
    func testAdd() {
        
        interactor.output = self

        //Test add to Queue

        interactor.addToQueue(day)
        interactor.requestData()

        // Test add to Linked List

        interactor.addToLinkedList(with: day.id, record: record1)
        interactor.addToLinkedList(with: day.id, record: record2)
        interactor.addToLinkedList(with: day.id, record: record3)

        // TODO: - Clean after testing
        
        _ = DBService.delete(day: day)
    }
}

extension AddInteractorTests: AddInteractorOutput {

    func presentData(_ data: Queue<Day>) {
        guard let expectedDay = data.first(where: { $0.id == day.id }) else { return }
        XCTAssertEqual(expectedDay.id, day.id, "Reading fail")
        XCTAssertEqual(expectedDay.interval.startTime, day.interval.startTime, "Reading fail")
        XCTAssertEqual(expectedDay.interval.endTime, day.interval.endTime, "Reading fail")
        XCTAssertEqual(expectedDay.records.count, day.records.count, "Reading fail")
        
        var expectedRecord = expectedDay.records.head
        var index: Int = 0

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
            } else if index == 2 {
                XCTAssertEqual(expectedRecord!.data.interval.startTime, record3.interval.startTime, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.interval.endTime, record3.interval.endTime, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.name, record3.name, "Reading fail")
                XCTAssertEqual(expectedRecord!.data.surname, record3.surname, "Reading fail")
            }
            index += 1
            expectedRecord = expectedRecord?.next
        }
    }

    func error(with text: String) { }

    func done(with text: String) { }
}
