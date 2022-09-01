//
//  BestCapturedLivePhotoTests.swift
//  BestCapturedLivePhotoTests
//
//  Created by Furkan Erdoğan on 21.07.2022.
//

import XCTest
@testable import BestCapturedLivePhoto

class BestCapturedLivePhotoTests: XCTestCase {
    
    private var viewModel: PhotosViewModel!
    
    override func setUp() {
        
        super.setUp()
        
        
    }
    
    override func tearDown() {
        viewModel = nil
        
        super.tearDown()
    }
    
    func setupData() {
        
        let image = UIImage(named: "IMG_2127")
        
        viewModel.visionRequest()
        
    }

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

    func test1() {
        
    }

}
