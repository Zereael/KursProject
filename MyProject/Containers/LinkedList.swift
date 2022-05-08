//
//  LinkedList.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import Foundation

struct LinkedList<T> {
    
    // MARK: - Internal Properties

    var head: Node<T>?
    var tail: Node<T>?
    
    var isEmpty: Bool { head == nil }
    var count: Int {
        var currentIndex = 0
        var currentNode = head

        while currentNode != nil {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentIndex
    }

    // MARK: - Initialization

    init() { }

    // MARK: - Public Methods
    
    // Push new node to head of list
    mutating func push(_ data: T) {
        head = Node(data: data, next: head)
        tail = tail ?? head
    }

    // Insert new node to list after current index
    mutating func insert(_ data: T, after index: Int) -> Bool {
        guard let node = node(at: index) else { return false }
        node.next = Node(data: data, previsious: node, next: node.next)
        return true
    }

    // Append new node to tail of list
    mutating func append(_ data: T) {
        let node = Node(data: data, previsious: tail)
        tail?.next = node
        tail = node
        head = head ?? tail
    }

    // Get node from list by index
    func node(at index: Int) -> Node<T>? {
        var currentIndex = 0
        var currentNode = head

        while currentNode != nil && currentIndex != index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }

    // Remove first node from list
    mutating func removeFirst() {
        head = head?.next
        tail = head == nil ? nil : tail
    }

    // Remove last node from list
    mutating func removeLast() {
        guard let previsiousNode = tail?.previsious else {
            removeFirst()
            return
        }
        tail = previsiousNode
        previsiousNode.next = nil
    }

    // Remove node by current index
    mutating func remove(at index: Int) {
        guard let node = node(at: index) else { return }
        
        if node === tail {
            removeLast()
        } else if node === head {
            removeFirst()
        } else {
            let previsiousNode = node.previsious
            previsiousNode?.next = node.next
        }
    }
}
