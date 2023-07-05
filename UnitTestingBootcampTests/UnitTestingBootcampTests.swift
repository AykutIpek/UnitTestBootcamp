//
//  UnitTestingBootcampTests.swift
//  UnitTestingBootcampTests
//
//  Created by aykut ipek on 5.07.2023.
//

import XCTest
@testable import UnitTestingBootcamp

final class UnitTestingBootcampTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeTrue(){
        // Given
        let userIsPremium: Bool = true
        // When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        // Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeFalse(){
        // Given
        let userIsPremium: Bool = false
        // When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        // Then
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue(){
        // Given
        let userIsPremium: Bool = Bool.random()
        // When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        // Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    
    
}
