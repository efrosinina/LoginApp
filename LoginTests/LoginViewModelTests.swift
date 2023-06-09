//
// LoginViewModelTests.swift
//  LoginTests
//
//  Created by Елизавета Ефросинина on 09/06/2023.
//

import XCTest
@testable import Login

final class LoginViewModelTests: XCTestCase {
    //MARK: -- Properties
    private var sut: LoginViewModel!
    
    //MARK: -- Life cycle
    override func setUp() {
        sut = LoginViewModel()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    //MARK: -- Tests
    func test_checkEmail_SuccessPath() {
        //When
        let result = sut.checkEmail(email: "some@gmail.com")
        //Then
        XCTAssertTrue(result)
    }
    
    func test_checkEmail_FailesWhenEmailIsEmpty() {
        //When
        let result = sut.checkEmail(email: "")
        //Then
        XCTAssertFalse(result)
    }
    
    func test_checkEmail_FailesWhenEmailWithoutAt() {
        //When
        let result = sut.checkEmail(email: "somegmail.com")
        //Then
        XCTAssertFalse(result)
    }
    
    func test_checkEmail_FailesWhenEmailWithoutDot() {
        //When
        let result = sut.checkEmail(email: "some@gmailcom")
        //Then
        XCTAssertFalse(result)
    }
    
    func test_checkPassword_SuccessPath() {
        //When
        let result = sut.checkPassword(password: "Hello1234567")
        //Then
        XCTAssertTrue(result)
    }
    
    func test_checkPassword_FailesWhenPasswordWithoutCapitalLetter() {
        //When
        let result = sut.checkPassword(password: "hello12235")
        //Then
        XCTAssertFalse(result)
    }
    
    func test_checkPassword_FailesWhenPasswordIsEmpty() {
        //When
        let result = sut.checkPassword(password: "")
        //Then
        XCTAssertFalse(result)
    }
    
    func test_checkPassword_FailesWhenPasswordWithoutNumbers() {
        //When
        let result = sut.checkPassword(password: "Hello")
        //Then
        XCTAssertFalse(result)
    }
}
