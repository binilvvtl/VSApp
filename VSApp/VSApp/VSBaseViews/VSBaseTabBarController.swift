//
//  BaseTabBarController.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import UIKit


class VSBaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .lightGray
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .black
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        let homeViewController = Storyboards.productList.instantiateVC(ProductListViewController.self)
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "homekit"), selectedImage: UIImage(systemName: "homekit"))
        
        let profileViewController = ProfileViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [homeNavigationController, profileNavigationController]
      }

}


//@IBDesignable

//class VSTextField: UITextField {
//
//    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//
//    var errorMessage: String? {
//        didSet {
//            guard let errorMessage = errorMessage else {
//                self.rightView = nil
//                return
//            }
//            let errorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
//            errorLabel.text = errorMessage
//            errorLabel.textColor = .red
//            errorLabel.textAlignment = .right
//            self.rightView = errorLabel
//            self.rightViewMode = .always
//        }
//    }
//
//    override init(frame: CGRect) {
//            super.init(frame: frame)
//            self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
//        }
//
//        required init?(coder: NSCoder) {
//            super.init(coder: coder)
//            self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
//        }
//
//        @objc func textFieldDidChange() {
//            errorMessage = nil
//        }
//
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//}

@IBDesignable
class VSTextField: UITextField {
  @IBInspectable var leftPadding: CGFloat = 10
  @IBInspectable var rightPadding: CGFloat = 10
  @IBInspectable var topPadding: CGFloat = 0
  @IBInspectable var bottomPadding: CGFloat = 0

  let placeholderLabel = UILabel()

  var errorMessage: String? {
    didSet {
      guard let errorMessage = errorMessage else {
        self.rightView = nil
        return
      }
      let errorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
      errorLabel.text = errorMessage
      errorLabel.textColor = .red
      errorLabel.textAlignment = .right
      self.rightView = errorLabel
      self.rightViewMode = .always
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupPlaceholderLabel()
    self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupPlaceholderLabel()
    self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
  }

  func setupPlaceholderLabel() {
    placeholderLabel.text = placeholder
    placeholderLabel.font = font
    placeholderLabel.sizeToFit()
    placeholderLabel.frame.origin = CGPoint(x: leftPadding, y: topPadding + font!.lineHeight / 2)
    placeholderLabel.textColor = UIColor.lightGray
    addSubview(placeholderLabel)
  }

  @objc func textFieldDidChange() {
    errorMessage = nil
      guard let textValue = text, textValue.isEmpty  else {
          placeholderLabel.isHidden = false
          return
      }
    placeholderLabel.isHidden = true
  }

  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding))
  }

  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding))
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding))
  }
}
