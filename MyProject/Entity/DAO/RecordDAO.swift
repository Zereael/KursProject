//
//  RecordDAO.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import RealmSwift

class RecordDAO: Object {
    @Persisted var startTime: Date
    @Persisted var endTime: Date
    @Persisted var name: String
    @Persisted var surname: String

    // MARK: - Initialization

    convenience init(from entity: Record) {
        self.init()
        startTime = entity.interval.startTime
        endTime = entity.interval.endTime
        name = entity.name
        surname = entity.surname
    }
}
