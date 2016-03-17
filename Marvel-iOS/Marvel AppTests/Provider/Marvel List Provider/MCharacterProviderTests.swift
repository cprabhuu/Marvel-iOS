//
//  MCharacterProviderTests.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//  Copyright © 2016 My Own Company. All rights reserved.
//

import XCTest

class MCharacterProviderTests: XCTestCase {
    var charactersProvider : MCharactersProvider?
    
    override func setUp() {
        super.setUp()
        self.charactersProvider = MCharactersProvider()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCharacterCreateProvider() {
        XCTAssert(self.charactersProvider != nil, "TEST FAILED: No provider could be created.")
    }
    
    func testCharacterGetAllCharacters() {
        let allCharacters:XCTestExpectation = self.expectationWithDescription("allCharacters")
        self.charactersProvider?.charactersProviderGetAllCharactersWithLimit(80, offset: 0, onCompletion: { (characters, total, alert, errorCode, errorMessage) -> Void in
            XCTAssertEqual(errorCode, DRErrorCode.EverythingOKCode, "TEST FAILED: No response from api.")
            allCharacters.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(30.0, handler: nil)
    }
    
    func testCharacterGetCharacterByName() {
        let characterByName:XCTestExpectation = self.expectationWithDescription("characterByName")
        self.charactersProvider?.charactersProviderCharacterWithName("Hulk", limit: 80, offset: 0, onCompletion: { (characters, total, alert, errorCode, errorMessage) -> Void in
            XCTAssertEqual(errorCode, DRErrorCode.EverythingOKCode, "TEST FAILED: No response from api.")
            characterByName.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(30.0, handler: nil)
    }    
}
