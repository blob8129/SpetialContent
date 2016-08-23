//
//  SpetialContentOperationTests.swift
//  SpetialContent
//
//  Created by Andrey Volobuev on 17/05/16.
//  Copyright © 2016 Andrey Volobuev. All rights reserved.
//

import XCTest
@testable import SpetialContent

class SpetialContentOperationTests: XCTestCase {
    
    let noSpetialContent = "AAA"
    let spetialContentAllGroups = "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016 (bicepleft) http://www.nbcolympics.com (bicepright)"
    let spetialContentOneGroups = "@bob such a cool feature"
    let spetialContentTwoGroups = "@bob @john (success) such a cool feature;"
    

    func testSpecialContentOperationCallsNoContentCallbackOnNoSpecialContent(){
        
        let expectation = self.expectationWithDescription("Expect NoSpetialContentCallback call on noSpetialContent ")
        
        let specialContentOperation = SpecialContentOperation(input: self.noSpetialContent, callback: {c in}, noContentCallback: {
            expectation.fulfill()
        })
        specialContentOperation.start()
        self.waitForExpectationsWithTimeout(1.0) { error in }
    }
    
    func testSpecialContentOperationCallsSpetialContentCallbackOnSpecialContent(){
        
        let expectation = self.expectationWithDescription("Expect SpetialContentCallback call on SpetialContent ")
        
        let specialContentOperation = SpecialContentOperation(input: self.spetialContentAllGroups, callback: {c in
            XCTAssertEqual(c.keys.count, 3, "Groups count must be 3")
            expectation.fulfill()
            }, noContentCallback: {})
        
        specialContentOperation.start()
        self.waitForExpectationsWithTimeout(1.0) { error in }
    }
    
    func testSpecialContentOperationReturnsTwoGroups(){
        
        let expectation = self.expectationWithDescription("Expect SpetialContentCallback call on SpetialContent with two groups")
        
        let specialContentOperation = SpecialContentOperation(input: self.spetialContentTwoGroups, callback: {c in
            
            XCTAssertEqual(c.keys.count, 2, "Groups count must be 2")
            expectation.fulfill()
            
            }, noContentCallback: {})
        
        specialContentOperation.start()
        self.waitForExpectationsWithTimeout(1.0) { error in }
    }
    
    func testSpecialContentOperationReturnsOneGroup(){
        
        let expectation = self.expectationWithDescription("Expect SpetialContentCallback call on SpetialContent with one group")
        
        let specialContentOperation = SpecialContentOperation(input: self.spetialContentOneGroups, callback: {c in
            
            XCTAssertEqual(c.keys.count, 1, "Groups count must be 1")
            expectation.fulfill()
            
            }, noContentCallback: {})
        
        specialContentOperation.start()
        self.waitForExpectationsWithTimeout(1.0) { error in }
    }
    
    func testSpecialContentGetKeyByGroup(){
        XCTAssertEqual(SpetialContent.getKeyByGroup(SpetialContent.mentions.group), SpetialContent.mentions.key, "SpetialContent.getKeyByGroup for mentions must return mentions key")
        XCTAssertEqual(SpetialContent.getKeyByGroup(SpetialContent.emoticons.group), SpetialContent.emoticons.key, "SpetialContent.getKeyByGroup for emoticons must return emoticons key")
        XCTAssertEqual(SpetialContent.getKeyByGroup(SpetialContent.links.group), SpetialContent.links.key, "SpetialContent.getKeyByGroup for links must return links key")
        XCTAssertEqual(SpetialContent.getKeyByGroup(SpetialContent.links.group), SpetialContent.links.key, "SpetialContent.getKeyByGroup for links must return links key")
        XCTAssertEqual(SpetialContent.getKeyByGroup(4), "", "SpetialContent.getKeyByGroup for greter than 3 must return links empty string")
    }
}
