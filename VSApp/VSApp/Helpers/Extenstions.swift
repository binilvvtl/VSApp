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
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
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

}


public enum PredicateFormat {
  static let matchFormat = "SELF MATCHES %@"
}

public enum RegularExpression: String {
  case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
  case password = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
}
