//
//  ApiServiceTests.swift
//  SportsAppTests
//
//  Created by Mac on 30/05/2023.
//

import XCTest
@testable import SportsApp

final class ApiServiceTests: XCTestCase {
    var sut : NetworkService!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = NetworkManager()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testLoadDataFromApi(){
        let expectation = XCTestExpectation(description: "Teams Downloaded")
        var responseResult : [Teams]?
        var responseError : Error?
        
        guard let bundle = Bundle.unitTest.path(forResource: "ApiResponse", ofType: "json")else{
            XCTFail("teams not found")
            return
        }
        sut.loadData(url: ("\(URL(fileURLWithPath: bundle))")) { (result: MyResponse<Teams>? , error) in
            responseError = error
            responseResult = result?.result
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 5)
        
        XCTAssertNotNil(responseResult)
        XCTAssertNil(responseError)
        XCTAssertNotEqual(responseResult?.count, 0)
    }
    func testLoadDataFromApiFailureParse(){
        let expectation = XCTestExpectation(description: "Teams Downloaded")
        var responseResult : [Teams]?
        var responseError : Error?
        
        guard let bundle = Bundle.unitTest.path(forResource: "ApiResponseFailure", ofType: "json")else{
            XCTFail("teams not found")
            return
        }
        sut.loadData(url: ("\(URL(fileURLWithPath: bundle))")) { (result: MyResponse<Teams>? , error) in
            responseError = error
            responseResult = result?.result
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 5)
        
        XCTAssertNil(responseResult)
        XCTAssertNotNil(responseError)
    }
    
    func testLoadDataFromApiFailure(){
        let expectation = XCTestExpectation(description: "Teams Downloaded")
        var responseResult :[Teams]?
        var responseError : Error?
        
        sut.loadData(url: ("not valid")) { (result: MyResponse<Teams>? , error) in
            responseError = error
            responseResult = result?.result
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 5)
        
        XCTAssertNil(responseResult)
        XCTAssertNotNil(responseError)
    }
    
}
