//
//  VSBaseNavigationController.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import UIKit

class VSBaseNavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
  }
  
  private func setupNavigationBar() {
    navigationBar.barTintColor = .black
    navigationBar.tintColor = .white
    navigationBar.isTranslucent = false
  }
}
