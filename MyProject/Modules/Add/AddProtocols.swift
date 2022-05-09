//
//  AddProtocols.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import Foundation

// MARK: - View

protocol AddViewInput: AnyObject {
    func startLoader()
    func stopLoader()
    func configure(with model: AddModel)
}

protocol AddViewOutput: AnyObject {
    func refresh()
    func tapAddToQueue(date: Date, startTime: Date, endTime: Date)
    func tapAddToLinkedList(date: Int, time: Int, name: String, surname: String)
}

// MARK: - Interactor

protocol AddInteractorInput  {
    func requestData()
    func addToQueue(_ day: Day)
    func addToLinkedList(with id: String, record: Record)
}

protocol AddInteractorOutput: AnyObject {
    func presentData(_ data: Queue<Day>)
    func error(with text: String)
    func done(with text: String)
}

// MARK: - Router

protocol AddRouterInput: AnyObject {
    func showError(with text: String, completion: (() -> Void)?)
    func showDone(with text: String, completion: (() -> Void)?)
}
