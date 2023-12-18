//
//  TestsExtensions.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 14/12/23.
//

import XCTest

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
