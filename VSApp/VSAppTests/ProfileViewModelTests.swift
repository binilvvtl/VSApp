//
//  ProfileViewModelTests.swift
//  VSAppTests
//
//  Created by Binil-V on 06/02/23.
//

import XCTest
@testable import VSApp

final class ApiManagerProfileDetailSpy: ApiManagerProfileProtocol {
    
    var modelProfileDetail: Profile?
    var error: HandleError?
    
    func getProfileData(completion: @escaping (Result<Profile, VSApp.HandleError>) -> Void) {
      if let errorUnwrapped = error {
        completion(Result.failure(errorUnwrapped))
      } else {
        guard let modelUnwraped = modelProfileDetail else {
          completion(Result.failure(.unknown))
          return
        }
        completion(Result.success(modelUnwraped))
      }
    }

    func addStub(dataModel: Profile?, errorType: HandleError?) {
        modelProfileDetail = dataModel
      error = errorType
    }
}

final class ProfileViewModelTests: XCTestCase, ProfileAPIServiceCompletionProtocol {
    func didFinishFetchingProductListResponse(results: VSApp.Profile?, error: Error?) {
        debugPrint(error)
    }
    
    var profileData: Profile?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    var sut: ProfileViewModel!
    var apiServiceSpy: ApiManagerProfileDetailSpy!
    
    override func setUp() {
        super.setUp()
        profileData = testItem(for: "ProfileList")
        apiServiceSpy = ApiManagerProfileDetailSpy()
        sut = ProfileViewModel(with: apiServiceSpy)
        sut.delegate = self
    }
    
    func testGetProfileDataSuccess() {
        apiServiceSpy.addStub(dataModel: profileData, errorType: nil)
        sut.getProfileData()
        XCTAssertEqual(sut.profile?.id, "113441")
    }
    
    func testGetProfileDataFailure() {
        sut.profile = nil
        apiServiceSpy.addStub(dataModel: nil, errorType: HandleError.unknown)
        sut.getProfileData()
        XCTAssertNil(sut.profile)
    }
    
    func testNumberOfSections() {
        apiServiceSpy.addStub(dataModel: profileData, errorType: nil)
        sut.getProfileData()
        XCTAssertEqual(sut.numberofsection(), 7)
    }
    
    func testGetSectionHeaderTitle() {
        apiServiceSpy.addStub(dataModel: profileData, errorType: nil)
        sut.getProfileData()
        XCTAssertEqual(sut.getSectionHeaderTitle(index: 0), "id")
        XCTAssertEqual(sut.getSectionHeaderTitle(index: 1), "username")

    }
    
    func testGetRowTitle() {
        apiServiceSpy.addStub(dataModel: profileData, errorType: nil)
        sut.getProfileData()
        XCTAssertEqual(sut.getRowTitle(index: IndexPath(row: 0, section: 0)), "113441")
        XCTAssertEqual(sut.getRowTitle(index: IndexPath(row: 0, section: 1)), "wjohn")
    }
}
