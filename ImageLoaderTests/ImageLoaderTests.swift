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

    func testRequestCreationFailure() {
        let request = ImageLoader.default.request(image: "") {
            image, error in
            print("Shouldn't be here")
        }
        XCTAssertNil(request)
    }

    func testRequestCreation() {
        let request = ImageLoader.default.request(image: "https://placehold.it/50", autoStart: false) {
            image, error in
        }
        XCTAssert(request != nil)
    }

    func testImageLoading() {
        let loadExpectation = expectation(description: "Should load image")

        let request = ImageLoader.default.request(image: "https://placehold.it/50") {
            image, error in
            if let image = image {
                loadExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5) {
            error in
        }
    }
    
    func testImageLoadingFailure() {
        let loadExpectation = expectation(description: "Should load image")
        
        let request = ImageLoader.default.request(image: "https://toto/image.png") {
            image, error in
            if let error = error {
                loadExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5) {
            error in
        }
    }
}
