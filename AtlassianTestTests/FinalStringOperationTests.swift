//
//  FinalStringOperationTests.swift
//  AtlassianTest
//
//  Created by Andrey Volobuev on 18/05/16.
//  Copyright © 2016 Andrey Volobuev. All rights reserved.
//

import XCTest
@testable import AtlassianTest


class FinalStringOperationTests: XCTestCase {
    
    class TestFinalStringOperation: FinalStringOperation{
        override func getLinks() -> [[String: String]]{
            if input["links"]?.count == 1 {
                return [["url": "Test1", "title": "Test1"]]
            }else{
                return [["url": "Test1", "title": "Test1"], ["url": "Test2", "title": "Test2"]]
            }
        }
        
    }
    let inputTwoLinks = ["links": ["https://twitter.com/jdorfman/status/430511497475670016", "http://www.nbcolympics.com"],
        "mentions": ["@bob", "@john"],
        "emoticons": ["success", "bicepleft", "bicepright"]]
    let inputOneLink = ["links": ["https://twitter.com/jdorfman/status/430511497475670016"],
        "mentions": ["@bob", "@john"],
        "emoticons": ["success", "bicepleft", "bicepright"]]

    
    func testFinalStringForOneLink(){
        let expectation = self.expectationWithDescription("Expect finalString for one link")

        let finalStringOperation = TestFinalStringOperation(input: inputOneLink) { jsonDictionary in
            XCTAssertEqual(jsonDictionary["links"]?.count, 1, "Links count must be 1")

            expectation.fulfill()
        }
        
        finalStringOperation.start()
        self.waitForExpectationsWithTimeout(1) { error in }
    }
    func testFinalStringForTwoLinks(){
        let expectation = self.expectationWithDescription("Expect finalString for two link")
        
        let finalStringOperation = TestFinalStringOperation(input: inputTwoLinks) { jsonDictionary in
            XCTAssertEqual(jsonDictionary["links"]?.count, 2, "Links count must be 2")
            
            expectation.fulfill()
        }
        
        finalStringOperation.start()
        self.waitForExpectationsWithTimeout(1) { error in }
    }
    
}
