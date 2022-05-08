//
//  AddInteractor.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import Foundation

final class AddInteractor {
    
    // MARK: - Internal Properties
    
    weak var output: AddInteractorOutput!

    // MARK: - Private Properties

    private var queue = Queue<Day>()
}

extension AddInteractor: AddInteractorInput {

    func requestData() {
        queue = DBService.read()
        output.presentData(queue)
    }

    func addToQueue(_ day: Day) {
        queue.enqueue(day)
        let result = DBService.write(day: day)
        if result {
            output.done(with: "Добавление в очередь прошло успешно")
        } else {
            output.error(with: "Ошибка при добавлении в очередь")
        }
    }

    func addToLinkedList(with id: String, record: Record) {
        // search selected list by id
        guard var day = queue.first(where: { $0.id == id }) else {
            return
        }
        
        // search place for record in list
        var index = 0
        var currentRecord = day.records.head
        while currentRecord != nil {
            if currentRecord!.data.interval.startTime >= record.interval.endTime {
                break
            }
            index += 1
            currentRecord = currentRecord?.next
        }

        if index == 0 {
            day.records.push(record)
        } else {
            _ = day.records.insert(record, after: index - 1)
        }

        let dbResult = DBService.update(day: day)
        
        if dbResult {
            output.done(with: "Добавление в список прошло успешно")
        } else {
            output.error(with: "Ошибка при добавлении в список")
        }
    }
}
