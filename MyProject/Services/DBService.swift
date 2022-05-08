//
//  DBService.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import Foundation
import RealmSwift

protocol IDBService {
    static func read() -> Queue<Day>
    static func write(day: Day) -> Bool
    static func update(day: Day) -> Bool
    static func delete(day: Day) -> Bool
}

final class DBService: IDBService {

    // MARK: - IDBService protocol

    static func read() -> Queue<Day> {
        
        let realm = try! Realm()
        let resultsDAO = realm.objects(DayDAO.self)
        var results = Queue<Day>()
        for item in resultsDAO {
            results.enqueue(Day(from: item))
        }
        return results
    }

    static func write(day: Day) -> Bool {
        let realm = try! Realm()
        do {
            try realm.write {
                    realm.add(DayDAO(from: day))
                }
            return true
        } catch {
            return false
        }
    }

    static func update(day: Day) -> Bool {
        let realm = try! Realm()
        let selectedDay = realm.object(ofType: DayDAO.self, forPrimaryKey: day.id)

        let recordsDAO = List<RecordDAO>()
        var currentRecord = day.records.head
        while currentRecord != nil {
            recordsDAO.append(RecordDAO(from: currentRecord!.data))
            currentRecord = currentRecord?.next
        }
        do {
            try realm.write {
                selectedDay?.records = recordsDAO
            }
            return true
        } catch {
            return false
        }
    }

    static func delete(day: Day) -> Bool {
        let realm = try! Realm()
        guard let selectedDay = realm.object(ofType: DayDAO.self, forPrimaryKey: day.id) else { return false }
        do {
            try realm.write {
                realm.delete(selectedDay)
            }
            return true
        } catch {
            return false
        }
    }
}
