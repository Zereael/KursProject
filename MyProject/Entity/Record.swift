//
//  Record.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import Foundation

struct Record {

    // MARK: - Internal Properties

    var interval: Interval {
        get { return _interval }
        set { _interval = newValue }
    }
    var name: String {
        get { return _name }
        set { _name = newValue }
    }
    var surname: String {
        get { return _surname }
        set { _surname = newValue }
    }

    // MARK: - Private Properties

    private var _interval: Interval
    private var _name: String
    private var _surname: String

    // MARK: - Initialization

    init(starTime: Date, endTime: Date, name: String, surname: String) {
        _interval = Interval(startTime: starTime, endTime: endTime)
        _name = name
        _surname = surname
    }

    init(from dao: RecordDAO) {
        _interval = Interval(startTime: dao.startTime, endTime: dao.endTime)
        _name = dao.name
        _surname = dao.surname
    }
}
