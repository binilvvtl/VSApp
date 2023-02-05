//
//  Profile.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import Foundation

struct Profile: Decodable{
    let id: String
    let username: String?
    let firstName: String?
    let lastName: String?
    let dob: String?
    let address: String?
    let pointsEarned: String?
    let walletBalance: String?
}
