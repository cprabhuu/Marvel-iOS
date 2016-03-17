//
//  MComicProviderTests.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 16/03/2016.
//  Copyright © 2016 My Own Company. All rights reserved.
//

import XCTest

class MComicProviderTests: XCTestCase {
    var comicProvider : MComicProvider?
    
    override func setUp() {
        super.setUp()
        self.comicProvider = MComicProvider()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testComicCreateProvider() {
        XCTAssert(self.comicProvider != nil, "TEST FAILED: No provider could be created.")
    }
    
    func testComicGetAllComics() {
        let allComics:XCTestExpectation = self.expectationWithDescription("allComics")
        self.comicProvider?.comicProviderGetAllComicsForCharacterId(1009146, limit: 80, offset: 50, onCompletion: { (comics, total, alert, errorCode, errorMessage) -> Void in
            XCTAssertEqual(errorCode, DRErrorCode.EverythingOKCode, "TEST FAILED: No response from api.")
            allComics.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(30.0, handler: nil)
    }
}
