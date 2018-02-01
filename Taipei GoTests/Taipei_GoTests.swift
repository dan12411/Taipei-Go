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
        let viewModel = DataTaipeiViewModel()
        let randomNumber = Int(arc4random_uniform(5)+1)
        viewModel.limit = randomNumber
        var dataSource: [Result] = []
        
        viewModel.fetchData{ data in
            dataSource = data
            XCTAssert(dataSource.count == randomNumber, "Fetch Data count not match")
        }
        
    }
    
}
