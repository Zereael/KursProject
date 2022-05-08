//
//  DayDAO.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import RealmSwift

class DayDAO: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var startTime: Date
    @Persisted var endTime: Date

    @Persisted var records: List<RecordDAO>

    // MARK: - Initialization

    convenience init(from entity: Day) {
        self.init()
        _id = entity.id
        startTime = entity.interval.startTime
        endTime = entity.interval.endTime
        records = List<RecordDAO>()
        var item = entity.records.head
        while item != nil {
            records.append(RecordDAO(from: item!.data))
            item = item?.next
        }
    }
}
