//
//  MapPackedTests.swift
//  MessagePackerTests
//
//  Created by Hirotaka Nishiyama on 2018/11/11.
//  Copyright © 2018年 hiro. All rights reserved.
//

import XCTest
@testable import MessagePacker

class MapPackedTests: XCTestCase {
    let encoder = MessagePackEncoder()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNilMap() {
        let input: [String: Double?] = ["1": nil]
        let output = Data([129, 161, 49, 192])
        XCTAssertEqual(try encoder.encode(input), output)
    }

    func testFixMap() {
        let input = ["1": 1.1]
        let output = Data([129, 161, 49, 203, 63, 241, 153, 153, 153, 153, 153, 154])
        XCTAssertEqual(try encoder.encode(input), output)
    }

    func testMap16() {
        let input = (0..<0xf).reduce(into: [String: Int]()) { $0[String($1)] = $1 }
        let output = 53
        XCTAssertEqual((try encoder.encode(input)).count, output)
    }

    func testMap32() {
        let input = (0..<0x10000).reduce(into: [String: Int]()) { $0[String($1)] = $1 }
        let output = 643999
        XCTAssertEqual((try encoder.encode(input)).count, output)
    }


    func test2DimensionalMap() {
        let input = ["a": ["b": 2]]
        let output = Data([129, 161, 97, 129, 161, 98, 2])
        XCTAssertEqual(try encoder.encode(input), output)
    }
}
