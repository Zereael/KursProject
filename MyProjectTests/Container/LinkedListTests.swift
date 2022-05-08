//
//  LinkedListTests.swift
//  MyProjectTests
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import XCTest
@testable import MyProject

// MARK: - Tests for LinkedList class

final class LinkedListTests: XCTestCase {

    // Create LinkedList
    func testCreateLinkedList() {
        let list = LinkedList<Int>()
        XCTAssertNotNil(list)
    }

    // Test count of elements
    func testCount() {
        var list = LinkedList<Int>()
        XCTAssertEqual(list.count, 0, "Test count failed")

        list.push(123)
        XCTAssertEqual(list.count, 1, "Test count failed")

        list.push(456)
        list.push(789)
        XCTAssertEqual(list.count, 3, "Test count failed")
    }

    // Push new node to head of list
    func testPushNode() {
        var list = LinkedList<Int>()

        // Node to empty list
        list.push(123)
        XCTAssertNotNil(list.head, "Node pushing failed")
        guard let head = list.head else { return }
        XCTAssertEqual(head.data, 123, "Node pushing failed")
        XCTAssertNil(head.next, "Node pushing failed")
        
        // Node to non-empty list
        list.push(456)
        XCTAssertNotNil(list.head, "Node pushing failed")
        guard let head = list.head else { return }
        XCTAssertEqual(head.data, 456, "Node pushing failed")
        XCTAssertNotNil(head.next, "Node pushing failed")
    }

    // Insert new node to list after current index
    func testInsertNode() {
        var list = LinkedList<Int>()
        
        // Node to empty list
        var result = list.insert(5, after: 4)
        XCTAssertFalse(result, "Node insert failed")

        // Node to non-empty list
        list.push(0)
        list.push(1)
        list.push(2)
        list.push(3)
        result = list.insert(127, after: 2)
        XCTAssertTrue(result, "Node insert failed")
    }

    // Append new node to tail of list
    func testAppend() {
        var list = LinkedList<Int>()
        
        // Node to empty list
        list.append(123)
        XCTAssertNotNil(list.head, "Node append failed")
        XCTAssertNotNil(list.tail, "Node append failed")

        guard let tail = list.tail else { return }
        guard let head = list.head else { return }

        XCTAssertEqual(tail.data, 123, "Node append failed")
        XCTAssertEqual(head.data, 123, "Node append failed")

        XCTAssertNil(tail.next, "Node append failed")
        
        // Node to non-empty list
        list.append(456)
        XCTAssertNotNil(list.head, "Node append failed")
        XCTAssertNotNil(list.tail, "Node append failed")

        guard let tail = list.tail else { return }

        XCTAssertEqual(tail.data, 456, "Node append failed")
        XCTAssertNil(tail.next, "Node append failed")
    }

    // Get node from list by index
    func testGetNode() {
        var list = LinkedList<Int>()
        list.append(56)
        list.append(10)
        list.append(25)
        list.append(38)
        
        let node = list.node(at: 2)
        XCTAssertNotNil(node, "Get node by index failed")

        guard let node = node else { return }

        XCTAssertEqual(node.data, 25, "Get node by index failed")
        
        let errorNode = list.node(at: 22)
        XCTAssertNil(errorNode, "Get node by index failed")
    }

    // Remove first node from list
    func testRemoveFirst() {
        var list = LinkedList<Int>()
        
        // From empty list
        list.removeFirst()
        XCTAssertNil(list.head, "Node removing failed")

        // From list with one node
        list.append(56)
        list.removeFirst()
        XCTAssertNil(list.head, "Node removing failed")
        XCTAssertNil(list.tail, "Node removing failed")

        // From non-empty list
        list.append(56)
        list.append(10)
        list.append(25)
        list.append(38)
        
        list.removeFirst()
        XCTAssertNotNil(list.head, "Node removing failed")

        guard let head = list.head else { return }

        XCTAssertEqual(head.data, 10, "Node removing failed")
    }

    // Remove last node from list
    func testRemoveLast() {
        var list = LinkedList<Int>()
        
        // From empty list
        list.removeLast()
        XCTAssertNil(list.head, "Node removing failed")
        XCTAssertNil(list.tail, "Node removing failed")

        // From list with one node
        list.append(56)
        list.removeLast()
        XCTAssertNil(list.head, "Node removing failed")
        XCTAssertNil(list.tail, "Node removing failed")

        // From non-empty list
        list.append(56)
        list.append(10)
        list.append(25)
        list.append(38)
        
        list.removeLast()
        XCTAssertNotNil(list.tail, "Node removing failed")

        guard let tail = list.tail else { return }

        XCTAssertEqual(tail.data, 25, "Node removing failed")
        XCTAssertNil(list.tail?.next, "Node removing failed")
    }

    // Remove node by current index
    func testRemoveByIndex() {
        var list = LinkedList<Int>()

        // From empty list
        list.remove(at: 5)
        XCTAssertNil(list.head, "Node removing failed")
        XCTAssertNil(list.tail, "Node removing failed")

        // From list with one node
        list.append(56)
        list.remove(at: 0)
        XCTAssertNil(list.head, "Node removing failed")
        XCTAssertNil(list.tail, "Node removing failed")

        // From non-empty list
        list.append(56)
        list.append(10)
        list.append(25)
        list.append(38)

        let afterNode = list.node(at: 2)

        list.remove(at: 1)

        let node = list.node(at: 1)
        XCTAssertNotNil(node, "Node removing failed")

        XCTAssertEqual(node?.data, afterNode?.data, "Node removing failed")
        
        // Remove last node
        list.remove(at: 2)
        
        XCTAssertNotNil(list.tail, "Node removing failed")

        guard let tail = list.tail else { return }

        XCTAssertEqual(tail.data, 25, "Node removing failed")
        XCTAssertNil(list.tail?.next, "Node removing failed")

        // Remove first node
        list.append(10)
        list.append(38)
        
        list.remove(at: 0)
        XCTAssertNotNil(list.head, "Node removing failed")

        guard let head = list.head else { return }

        XCTAssertEqual(head.data, 25, "Node removing failed")
        XCTAssertNotNil(head.next, "Node removing failed")
    }
}
