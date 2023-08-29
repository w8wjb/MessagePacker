//
//  IntegerPackedTests.swift
//  MessagePackerTests
//
//  Created by Hirotaka Nishiyama on 2018/11/11.
//  Copyright © 2018年 hiro. All rights reserved.
//

import XCTest
@testable import MessagePacker

class IntegerPackedTests: XCTestCase {
    let encoder = MessagePackEncoder()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNegativeFixint() {
        let input = -1
        let output = Data([255])
        XCTAssertEqual(try encoder.encode(input), output)
    }

    func testPositiveFixint() {
        let input = 1
        let output = Data([1])
        XCTAssertEqual(try encoder.encode(input), output)
    }

    func testInt8() {
        let input = -127
        let output = Data([0xd0, 129])
        XCTAssertEqual(try encoder.encode(Int(input)), output)
        XCTAssertEqual(try encoder.encode(Int8(input)), output)
    }

    func testUInt8() {
        let input = 255
        let output = Data([0xcc, 255])
        XCTAssertEqual(try encoder.encode(UInt(input)), output)
        XCTAssertEqual(try encoder.encode(UInt8(input)), output)
    }

    func testInt16Negative() {
        let input = -32767
        let output = Data([0xd1, 128, 1])
        XCTAssertEqual(try encoder.encode(Int(input)), output)
        XCTAssertEqual(try encoder.encode(Int16(input)), output)
    }
    
    func testInt16Positive() {
        let input = 32767
        let output = Data([0xd1, 0x7f, 0xff])
        XCTAssertEqual(try encoder.encode(Int(input)), output)
        XCTAssertEqual(try encoder.encode(Int16(input)), output)
    }


    func testUInt16() {
        let input = 65535
        let output = Data([0xcd, 255, 255])
        XCTAssertEqual(try encoder.encode(UInt(input)), output)
        XCTAssertEqual(try encoder.encode(UInt16(input)), output)
    }

    func testInt32Negative() {
        let input = -65536
        let output = Data([0xd2, 255, 255, 0, 0])
        XCTAssertEqual(try encoder.encode(Int(input)), output)
        XCTAssertEqual(try encoder.encode(Int32(input)), output)
    }
    
    func testInt32Positive() {
        let input = 65536
        let output = Data([0xd2, 0, 1, 0, 0])
        XCTAssertEqual(try encoder.encode(Int(input)), output)
        XCTAssertEqual(try encoder.encode(Int32(input)), output)
    }

    func testUInt32() {
        let input: UInt32 = 4294967295
        let output = Data([0xce, 255, 255, 255, 255])
        XCTAssertEqual(try encoder.encode(UInt(input)), output)
        XCTAssertEqual(try encoder.encode(UInt32(input)), output)
    }

    func testInt64() {
        let input: Int64 = -4294967296
        let output = Data([0xd3, 255, 255, 255, 255, 0, 0, 0, 0])
        XCTAssertEqual(try encoder.encode(input), output)
    }

    func testUInt64() {
        let input: UInt64 = 18446744073709551615
        let output = Data([0xcf, 255, 255, 255, 255, 255, 255, 255, 255])
        XCTAssertEqual(try encoder.encode(input), output)
    }
}
