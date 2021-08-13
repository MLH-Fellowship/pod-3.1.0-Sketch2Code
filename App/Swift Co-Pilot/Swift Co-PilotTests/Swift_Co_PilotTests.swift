//
//  Swift_Co_PilotTests.swift
//  Swift Co-PilotTests
//
//  Created by Prabaljit Walia on 29/07/21.
//

import XCTest
@testable import Swift_Co_Pilot

class Swift_Co_PilotTests: XCTestCase {
    private var history:HistoryTableViewController!
    private var viewController:ViewController!
    private var sut: URLSession!


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        history = HistoryTableViewController()
        viewController = ViewController()
        sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetTitles() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        history.newGet()
        XCTAssertTrue(history.titles != [""])
        
    }
    func testGetCodes() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        history.newGet()
        XCTAssertTrue(history.codes != [""])
        
    }
    // Asynchronous test: success fast, failure slow
    func testValidApiCallGetsHTTPStatusCode200() throws {
      // given
      let urlString =
        "http://sketch2code.tech/history"
      let url = URL(string: urlString)!
      let promise = expectation(description: "Status code: 200")

      let dataTask = sut.dataTask(with: url) { _, response, error in
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
