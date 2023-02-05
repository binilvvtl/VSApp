//
//  ProfileViewModel.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import Foundation


protocol ProfileAPIServiceCompletionProtocol: NSObject {
    func didFinishFetchingProductListResponse(results: Profile?, error: Error?)
}


class ProfileViewModel {
    
    private var apiService: ApiManagerProfileProtocol?
    var profile: Profile?
    weak var delegate: ProfileAPIServiceCompletionProtocol?
    
    
    var dictionary: [String: String] = [:]
    var keyArray:[String] = []
    
    init(with service: ApiManagerProfileProtocol = APIService()) {
        apiService = service
    }
    
    func getProfileData() {
        apiService?.getProfileData{ [weak self] response in
            switch response {
            case .success(let data):
                self?.profile = data
                self?.setDictonary()
                self?.delegate?.didFinishFetchingProductListResponse(results: data, error: nil)
            case .failure(let error):
                self?.delegate?.didFinishFetchingProductListResponse(results: nil, error: error)
            }
        }
    }
    
    func setDictonary() {
        guard let data = profile else { return }
        let mirror = Mirror(reflecting: data)
        keyArray.removeAll()
        for child in mirror.children {
            if let key = child.label, let value = child.value as? String {
                dictionary[key] = value
                keyArray.append(key)
            }
        }
    }
    
    func numberofsection() -> Int {
        return keyArray.count
    }
    
    func getSectionHeaderTitle(index: Int) -> String {
        return keyArray[index]
    }
    
    func getRowTitle(index: IndexPath) -> String {
        return dictionary[getSectionHeaderTitle(index: index.section)] ?? ""
    }
    
}
