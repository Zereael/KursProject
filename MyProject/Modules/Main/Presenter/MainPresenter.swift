//
//  MainPresenter.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import Foundation

final class MainPresenter {
    
    // MARK: - Internal Properties
    
    weak var view: MainViewInput!
    var interactor: MainInteractorInput!
    var router: MainRouterInput!
}

extension MainPresenter: MainViewOutput {

    func refresh() {
        view.startLoader()
        interactor.requestData()
    }

    func tapAdd() {
        router.showAdd()
    }

    func delete(at indexPath: IndexPath) {
        interactor.delete(at: indexPath)
    }

    func dequeue() {
        interactor.dequeue()
    }
}

extension MainPresenter: MainInteractorOutput {

    func presentData(_ data: Queue<Day>) {
        var sections: [Section] = []
        for item in data {
            sections.append(Section(from: item))
        }
        view.stopLoader()
        if sections.count == 0 {
            view.showEmptyView()
        } else {
            view.hideEmptyView()
            view.configure(with: MainModel(sections: sections))
        }
    }

    func deleted(at indexPath: IndexPath) {
        view.deleted(at: indexPath)
    }

    func dequeued() {
        view.deleteFirstSection()
    }
}
