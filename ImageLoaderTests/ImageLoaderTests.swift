//
//  ImageLoaderTests.swift
//  ImageLoaderTests
//
//  Created by Paul-Emmanuel on 13/12/16.
//  Copyright © 2016 rstudio. All rights reserved.
//

import XCTest
import ImageLoader

class ImageLoaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testBadURL() {
        ImageLoader.default.load(image: "https://toto?image") {
            image, error
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
