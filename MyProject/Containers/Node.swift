//
//  Node.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import Foundation

final class Node<T> {
    
    // MARK: - Internal Properties

    var data: T
    var previsious: Node?
    var next: Node?

    // MARK: - Initialization
    
    init(data: T, previsious: Node<T>? = nil, next: Node<T>? = nil) {
        self.data = data
        self.previsious = previsious
        self.next = next
    }
}
