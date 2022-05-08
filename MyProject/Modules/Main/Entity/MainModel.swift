//
//  MainModel.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import Foundation

struct MainModel {

    // MARK: - Internal Properties

    var sections: [Section]
}

struct Section {

    // MARK: - Internal Properties

    var title: String
    var rows: [Row] = []

    // MARK: - Private Properties

    private let dateService: IDateService = DateService()

    // MARK: - Initialization

    init(from entity: Day) {
        title = "\(dateService.dateToString(entity.interval.startTime)), \(dateService.timeToString(entity.interval.startTime)) - \(dateService.timeToString(entity.interval.endTime))"
        var currentRecord = entity.records.head
        while currentRecord != nil {
            rows.append(Row.init(from: currentRecord!.data))
            currentRecord = currentRecord?.next
        }
    }
}

struct Row {

    // MARK: - Internal Properties

    var title: String
    var subtitle: String

    // MARK: - Private Properties

    private let dateService: IDateService = DateService()

    // MARK: - Initialization

    init(from entity: Record) {
        title = "\(entity.name) \(entity.surname)"
        subtitle = "\(dateService.timeToString(entity.interval.startTime)) - \(dateService.timeToString(entity.interval.endTime))"
    }
}
