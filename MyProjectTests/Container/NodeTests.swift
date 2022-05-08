//
//  NodeTests.swift
//  MyProjectTests
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import XCTest
@testable import MyProject

// MARK: - Tests for Node class

final class NodeTests: XCTestCase {

    func testCreateNode() {
        let node = Node<Int>(data: 123)
        XCTAssertEqual(node.data, 123, "Node creation failed")
    }
}
