//
//  QueueTests.swift
//  MyProjectTests
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import XCTest
@testable import MyProject

// MARK: - Tests for Queue class

final class QueueTests: XCTestCase {

    // Create Queue
    func testCreateQueue() {
        let queue = Queue<Int>()
        XCTAssertNotNil(queue, "Queue creation failed")
    }

    // Add element to queue
    func testEnqueue() {
        var queue = Queue<Int>()
        
        // To empty queue
        queue.enqueue(45)
        XCTAssertEqual(queue.count, 1, "Element adding failed")
        XCTAssertEqual(queue.head, 45, "Element adding failed")
        XCTAssertEqual(queue.tail, 45, "Element adding failed")
        
        // To non-empty queue
        queue.enqueue(67)
        XCTAssertEqual(queue.count, 2, "Element adding failed")
        XCTAssertEqual(queue.head, 45, "Element adding failed")
        XCTAssertEqual(queue.tail, 67, "Element adding failed")

        queue.enqueue(89)
        XCTAssertEqual(queue.count, 3, "Element adding failed")
        XCTAssertEqual(queue.head, 45, "Element adding failed")
        XCTAssertEqual(queue.tail, 89, "Element adding failed")

    }

    // Remove element from queue
    func testDequeue() {
        var queue = Queue<Int>()
        
        // From empty queue
        var element = queue.dequeue()
        XCTAssertNil(element, "Element adding failed")
        XCTAssertEqual(queue.count, 0, "Element adding failed")
        XCTAssertNil(queue.head, "Element adding failed")
        XCTAssertNil(queue.tail, "Element adding failed")
        
        // From non-empty queue
        queue.enqueue(12)
        queue.enqueue(34)
        queue.enqueue(56)
        XCTAssertEqual(queue.count, 3, "Element adding failed")

        element = queue.dequeue()
        XCTAssertNotNil(element, "Element adding failed")
        XCTAssertEqual(element, 12, "Element adding failed")

        XCTAssertEqual(queue.count, 2, "Element adding failed")
        XCTAssertEqual(queue.head, 34, "Element adding failed")
        XCTAssertEqual(queue.tail, 56, "Element adding failed")
    }

    // Test Sequence, IteratorProtocol
    func testSequenceIteratorProtocol() {
        // For non-empty list
        var arrayOfData: [Int] = [56, 10, 25, 38]
        var queue = Queue<Int>()
        for item in arrayOfData {
            queue.enqueue(item)
        }

        var index = 0;
        for item in queue {
            XCTAssertEqual(item, arrayOfData[index], "Test Sequence, IteratorProtocol failed")
            index += 1
        }
        
        // For empty list
        arrayOfData = []
        var secondQueue = Queue<Int>()
        for item in arrayOfData {
            secondQueue.enqueue(item)
        }

        index = 0;
        for item in secondQueue {
            XCTAssertEqual(item, arrayOfData[index], "Test Sequence, IteratorProtocol failed")
            index += 1
        }

        // For list with one element
        arrayOfData = [12]
        var thirdQueue = Queue<Int>()
        for item in arrayOfData {
            thirdQueue.enqueue(item)
        }

        index = 0;
        for item in thirdQueue {
            XCTAssertEqual(item, arrayOfData[index], "Test Sequence, IteratorProtocol failed")
            index += 1
        }
    }
}
