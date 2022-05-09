//
//  Day.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import Foundation

struct Day {

    // MARK: - Internal Properties

    var id: String { return _id }
    var interval: Interval {
        get { return _interval }
        set { _interval = newValue }
    }
    var records: LinkedList<Record> {
        get { return _records }
        set { _records = newValue }
    }

    // MARK: - Private Properties

    private let _id: String
    private var _interval: Interval
    private var _records: LinkedList<Record>

    // MARK: - Initialization

    init(id: String, startTime: Date, endTime: Date, records: LinkedList<Record> = LinkedList<Record>()) {
        _id = id
        _interval = Interval(startTime: startTime, endTime: endTime)
        _records = records
    }

    init(from dao: DayDAO) {
        _id = dao._id
        _interval = Interval(startTime: dao.startTime, endTime: dao.endTime)
        var records = LinkedList<Record>()
        for record in dao.records {
            records.append(Record(from: record))
        }
        _records = records
    }
}
