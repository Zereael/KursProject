//
//  Queue.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import Foundation

struct Queue<T>: Sequence, IteratorProtocol {

    // MARK: - Internal Properties

    var head: T? { return elements.first }

    var tail: T? { return elements.last }

    var count: Int { return elements.count }

    // MARK: - Private Properties

    private var elements: [T] = []
    private var current: Int

    // MARK: - Initialization

    init() {
        current = 0
    }

    // MARK: - Public Methods

    // Add element to queue
    mutating func enqueue(_ value: T) {
        elements.append(value)
    }

    // Remove element from queue
    mutating func dequeue() -> T? {
        guard !elements.isEmpty else { return nil }
        return elements.removeFirst()
    }

    // MARK: - Sequence, IteratorProtocol

    mutating func next() -> T? {
        current += 1
        guard current <= count else { return nil }
        return elements[current - 1]
    }
}
