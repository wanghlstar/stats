//
//  RAM.swift
//  Tests
//
//  Created by Serhiy Mytrovtsiy on 16/04/2022.
//  Using Swift 5.0.
//  Running on macOS 10.15.
//
//  Copyright © 2022 Serhiy Mytrovtsiy. All rights reserved.
//

import XCTest
import RAM

class RAM: XCTestCase {
    func testProcessReader_parseProcess() throws {
        var process = try XCTUnwrap(ProcessReader.parseProcess("  8178 743824 JSCode Helper (Renderer)"))
        XCTAssertEqual(process.pid, 8178)
        XCTAssertEqual(process.name, "JSCode Helper (Renderer)")
        XCTAssertEqual(process.usage, 743824 * 1024)
        
        process = try XCTUnwrap(ProcessReader.parseProcess("    1   9824 launchd"))
        XCTAssertEqual(process.pid, 1)
        XCTAssertEqual(process.name, "launchd")
        XCTAssertEqual(process.usage, 9824 * 1024)
        
        process = try XCTUnwrap(ProcessReader.parseProcess("  163 104416 WindowServer"))
        XCTAssertEqual(process.pid, 163)
        XCTAssertEqual(process.name, "WindowServer")
        XCTAssertEqual(process.usage, 104416 * 1024)
    }
    
    func testKernelTask() throws {
        let process = try XCTUnwrap(ProcessReader.parseProcess("    0 270000 kernel_task"))
        XCTAssertEqual(process.pid, 0)
        XCTAssertEqual(process.name, "kernel_task")
        XCTAssertEqual(process.usage, 270000 * 1024)
    }
    
    func testInvalidLines() throws {
        XCTAssertNil(ProcessReader.parseProcess("  PID    RSS COMM"))
        XCTAssertNil(ProcessReader.parseProcess(""))
        XCTAssertNil(ProcessReader.parseProcess("not a ps line"))
        XCTAssertNil(ProcessReader.parseProcess("123"))
    }
}
