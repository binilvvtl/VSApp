//
//  LoginViewModelTests.swift
//  VSAppTests
//
//  Created by Binil-V on 06/02/23.
//

import XCTest
@testable import VSApp


final class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    override func setUpWithError() throws {
        try? super.setUpWithError()
        viewModel = LoginViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try? super.tearDownWithError()
    }
    
    func testEmailValidation_withValidEmail() {
        viewModel.email = "test@test.com"
        XCTAssertNil(viewModel.emailValidation)
    }
    
    func testEmailValidation_withInvalidEmail() {
        viewModel.email = "testtest.com"
        XCTAssertNotNil(viewModel.emailValidation)
    }
    
    func testPasswordValidation_withValidPassword() {
        viewModel.password = "Password123!"
        XCTAssertNil(viewModel.passwordValidation)
    }
    
    func testPasswordValidation_withInvalidPassword() {
        viewModel.password = "password"
        XCTAssertNotNil(viewModel.passwordValidation)
    }
    
    func testIsValid_withValidCredentials() {
        viewModel.email = "test@test.com"
        viewModel.password = "Password123!"
        XCTAssertTrue(viewModel.isValid)
    }
    
    func testIsValid_withInvalidCredentials() {
        viewModel.email = "testtest.com"
        viewModel.password = "password"
        XCTAssertFalse(viewModel.isValid)
    }
}
