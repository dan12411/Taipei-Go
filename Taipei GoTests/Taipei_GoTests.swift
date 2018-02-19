//
//  Taipei_GoTests.swift
//  Taipei GoTests
//
//  Created by 洪德晟 on 30/01/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import XCTest
@testable import Taipei_Go

class Taipei_GoTests: XCTestCase {
    
    func testFetchData() {
        let viewModel = TouristSiteViewModel(page: 0)
        let randomNumber = Int(arc4random_uniform(5)+1)
        let fetchDataExpectation = XCTestExpectation(description: "Fetch data")
        
        viewModel.page = randomNumber
        var dataSource: [Result] = []
        
        viewModel.fetchData{ data in
            dataSource = data
            XCTAssertNotNil(data, "Failed to fetch data")
            fetchDataExpectation.fulfill()
        }
        
        wait(for: [fetchDataExpectation], timeout: 30)
        XCTAssert(dataSource.count == 5, "Fetch Data count not match")
        
        for data in dataSource {
            XCTAssertNotNil(data.file, "data file is Nil")
            XCTAssertNotNil(data.RowNumber, "data RowNumber is Nil")
            XCTAssertNotNil(data.stitle, "data stitle is Nil")
            XCTAssertNotNil(data.xbody, "data xbody is Nil")
        }
    }
    
}
