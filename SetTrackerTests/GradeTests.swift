//
//  GradeTests.swift
//  SetTrackerTests
//
//  Created by Brady Robshaw on 6/9/23.
//

import XCTest
@testable import SetTracker

final class GradeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
    
    func testV5GreaterthanV3() {
        let v5 = Grade(planded: 5)
        let v3 = Grade(planded: 3)
        XCTAssertTrue(v5 > v3)
    }
    
    func testV6GreaterthanNil() {
        let v6 = Grade(planded: 5)
        let nilGrade = Grade(planded: nil)
        XCTAssertTrue(v6 > nilGrade)
    }
    
    func testGradeSort() {
        let preSort = [Grade(planded: nil), Grade(planded: 1), Grade(planded: 10), Grade(planded: 2)]
        let result = [Grade(planded: 1), Grade(planded: 2), Grade(planded: 10), Grade(planded: nil)]
        
        XCTAssertEqual(preSort.sorted() , result)
    }
    
    func testGradeReversSort() {
        let preSort = [Grade(planded: nil), Grade(planded: 1), Grade(planded: 10), Grade(planded: 2)]
        let result = [Grade(planded: 10), Grade(planded: 2), Grade(planded: 1), Grade(planded: nil)]
        XCTAssertEqual(preSort.sorted(by: >), result)
    }

}
