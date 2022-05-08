//
//  MainProtocols.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import Foundation

// MARK: - View

protocol MainViewInput: AnyObject {
    func showEmptyView()
    func hideEmptyView()
    func startLoader()
    func stopLoader()
    func configure(with model: MainModel)
    func deleted(at indexPath: IndexPath)
    func deleteFirstSection()
}

protocol MainViewOutput: AnyObject {
    func refresh()
    func tapAdd()
    func delete(at indexPath: IndexPath)
    func dequeue()
}

// MARK: - Interactor

protocol MainInteractorInput  {
    func requestData()
    func delete(at indexPath: IndexPath)
    func dequeue()
}

protocol MainInteractorOutput: AnyObject {
    func presentData(_ data: Queue<Day>)
    func deleted(at indexPath: IndexPath)
    func dequeued()
}

// MARK: - Router

protocol MainRouterInput: AnyObject {
    func showAdd()
}
