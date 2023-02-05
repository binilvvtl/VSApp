//
//  Storyboards.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import UIKit

enum Storyboards: String {
case productList = "ProductList"

case login = "Main"
    
    var instance: UIStoryboard {
      return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    func instantiateVC<T: UIViewController>(_ objectClass: T.Type) -> T {
      return instance.instantiateViewController(withIdentifier: String.getStringOfClass(objectClass: objectClass)) as! T
    }
}
