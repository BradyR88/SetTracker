//
//  ClimbTest.swift
//  SetTrackerTests
//
//  Created by Brady Robshaw on 6/9/23.
//

import XCTest
@testable import SetTracker

final class ClimbTest: XCTestCase {
    var sut: Climb!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = Climb(seter: "Brady", dateUp: Date(timeIntervalSince1970: 1685484567), dateDown: Date(timeIntervalSince1970: 1686348567), style: [.crimp,.morpho], grade: Grade(planded: 7, actual: nil))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDaysUpIsEqualToTen() {
        XCTAssertEqual(sut.daysUp, 10)
    }
    
    func testIsUpIsFalse() {
        XCTAssertFalse(sut.isUp)
    }

}
