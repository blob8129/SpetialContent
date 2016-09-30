//
//  PageTitleOperationTests.swift
//  SpetialContent
//
//  Created by Andrey Volobuev on 17/05/16.
//  Copyright © 2016 Andrey Volobuev. All rights reserved.
//

import XCTest
@testable import SpetialContent


class PageTitleOperationTests: XCTestCase {
    
    class TestPageTitleOperation: PageTitleOperation {
        override func getWebPageContentForUrl(url: NSURL) -> String? {
            return "input <!DOCTYPE html><head><title>2016 Rio Olympic Games | NBC Olympics</title><body></body>"
        }
    }
    
    func testPageTitleOperationReturnsTitle() {
        let testPageTitleOperation = TestPageTitleOperation(link: "")
        testPageTitleOperation.start()
        XCTAssertEqual(testPageTitleOperation.title, "2016 Rio Olympic Games | NBC Olympics", "PageTitleOperation must return title")
    }
}
