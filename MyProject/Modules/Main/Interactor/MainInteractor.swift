//
//  MainInteractor.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import Foundation

final class MainInteractor {
    
    // MARK: - Internal Properties
    
    weak var output: MainInteractorOutput!

    // MARK: - Private Properties

    private var queue = Queue<Day>()
}

extension MainInteractor: MainInteractorInput {
    
    func requestData() {
        queue = DBService.read()
        output.presentData(queue)
    }

    func delete(at indexPath: IndexPath) {
        var index = 0;
        var currentDay = queue.head

        for item in queue {
            currentDay = item
            if index == indexPath.section {
                break
            }
            index += 1
        }

        guard var day = currentDay else { return }
        day.records.remove(at: indexPath.row)
        
        if DBService.update(day: day) {
            output.deleted(at: indexPath)
        }
    }

    func dequeue() {
        guard let deletedDay = queue.dequeue() else { return }
        if DBService.delete(day: deletedDay) {
            output.dequeued()
        }
    }
}
