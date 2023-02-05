//
//  Extenstions.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import UIKit

extension UIViewController {
    
    // Global Alert
    // Define Your number of buttons, styles and completion
    public func openAlert(title: String,
                          message: String,
                          alertStyle:UIAlertController.Style,
                          actionTitles:[String],
                          actionStyles:[UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)]){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[safe: index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
}

extension String {
    // to support localization
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    static func getStringOfClass(objectClass: AnyClass) -> String {
      let className = String(describing: objectClass.self)
      return className
    }
    
    func isValidEmail() -> Bool {
      let pred = NSPredicate(format: PredicateFormat.matchFormat, RegularExpression.email.rawValue)
      return pred.evaluate(with: self)
    }

    func isValidPassword() -> Bool {
      let passwordTest = NSPredicate(format: PredicateFormat.matchFormat, RegularExpression.password.rawValue)
      return passwordTest.evaluate(with: self)
    }
    
    func setupPricevalue(price: String?, offerPrice: String?) ->  NSMutableAttributedString? {
        
        let valueString = "Price: $\(price ?? "0")"
        guard let offerPrice = offerPrice else {
            return NSMutableAttributedString(string: valueString)
        }
        var offerString = "Offer Price: $\(offerPrice)"
        
        let attributedString = NSMutableAttributedString(string: valueString + "\n" + offerString)

        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 0, length: valueString.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: valueString.count))

        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 18), range: NSRange(location: valueString.count + 1, length: offerString.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: valueString.count + 1, length: offerString.count))
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: valueString.count))

        return attributedString
    }

}


public enum PredicateFormat {
  static let matchFormat = "SELF MATCHES %@"
}

public enum RegularExpression: String {
  case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
  case password = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*?[#?!@$%^&<>*~:`-]).{8,}"
}

extension UIView {
  
  static func name() -> String {
    return String(describing: self)
  }
}

extension UITableView {
  
  func registerCellTypes(_ cells: [UITableViewCell.Type]) {
    cells.forEach { registerCell($0) }
  }
  
  func registerCell<T: UITableViewCell>(_ cellName: T.Type) {
    self.register(UINib(nibName: cellName.name(), bundle: nil), forCellReuseIdentifier: cellName.name())
  }
  
  func registerCell(nibName: String, cellIdentifier: String) {
    self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
  }
  
  func dequeueCell<T: UITableViewCell>(_ cellName: T.Type, at indexPath: IndexPath) -> T? {
    guard let cell = self.dequeueReusableCell(withIdentifier: cellName.name(), for: indexPath) as? T else {
      return nil
    }
    return cell
  }
  
  func dequeueReusableCell<T: UITableViewCell>(_ className: T.Type, indexPath: IndexPath) -> T {
    return self.dequeueReusableCell(withIdentifier: className.name(), for: indexPath) as! T
  }
  
  func dequeueReusableCell<T: UITableViewCell>(withIdentifier: String, indexPath: IndexPath) -> T {
    return self.dequeueReusableCell(withIdentifier: withIdentifier, for: indexPath) as! T
  }
  
  func registerNib(_ className: AnyClass) {
    let classNameString = String.getStringOfClass(objectClass: className)
    register(UINib.init(nibName: classNameString, bundle: .main), forCellReuseIdentifier: classNameString)
  }
  
  func registerClass(_ className: AnyClass) {
    let classNameString = String.getStringOfClass(objectClass: className)
    register(className, forCellReuseIdentifier: classNameString)
  }
  
  func asyncReload() {
    DispatchQueue.main.async { [weak self] in
      self?.reloadData()
    }
  }
  
  func refresh() {
    self.beginUpdates()
    self.endUpdates()
  }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < count else {
            return nil
        }
        return self[index]
    }
}
