//
//  NewMockDataService_Tests.swift
//  UnitTestingBootcampTests
//
//  Created by aykut ipek on 8.07.2023.
//

import XCTest
@testable import UnitTestingBootcamp
import Combine


final class NewMockDataService_Tests: XCTestCase {
    
    var cancellabels = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        cancellabels.removeAll()
    }
    
    func test_NewMockDataService_init_doesNotValuesCorrectly(){
        // Given
        let items: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString, UUID().uuidString]
        // When
        let dataService = NewMockDataService(items: items)
        let dataService2 = NewMockDataService(items: items2)
        let dataService3 = NewMockDataService(items: items3)
        // Then
        XCTAssertFalse(dataService.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, items3?.count)
    }
    
    func test_NewMockDataService_downloadWithEscaping_doesReturnValues(){
        // Given
        let dataService = NewMockDataService(items: nil)
        // When
        var items: [String] = []
        let expectation = XCTestExpectation()
        dataService.downloadItemsWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_NewMockDataService_downloadWithCombine_doesReturnValues(){
        // Given
        let dataService = NewMockDataService(items: nil)
        // When
        var items: [String] = []
        let expectation = XCTestExpectation()
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion{
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail()
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellabels)

        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_NewMockDataService_downloadWithCombine_doesFail(){
        // Given
        let dataService = NewMockDataService(items: [])
        // When
        var items: [String] = []
        let expectation = XCTestExpectation(description: "Does throw error")
        let expectation2 = XCTestExpectation(description: "Does throw URLError.badServerResponse")
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion{
                case .finished:
                    XCTFail()
                case .failure(let error):
                    expectation.fulfill()
                    let urlError = error as? URLError
                    XCTAssertEqual(urlError, URLError(.badServerResponse))
                    
                    if urlError == URLError(.badServerResponse){
                        expectation2.fulfill()
                    }
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellabels)

        // Then
        wait(for: [expectation, expectation2], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }

}
