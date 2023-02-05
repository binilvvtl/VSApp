//
//  LoginViewController.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import UIKit
import SkyFloatingLabelTextField

final class LoginViewController: UIViewController {
    @IBOutlet private weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var passwordTextField: SkyFloatingLabelTextField!
    
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private  weak var showPassword: UIButton!
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupUI()
    }
    
    private func setupUI(){
        setupEamilTextfiled()
        setupPasswordTextfiled()
        submitButton.layer.cornerRadius = submitButton.frame.height / 2
        submitButton.clipsToBounds = true
    }
    
    private func setupEamilTextfiled() {
        emailTextField.placeholder = "Email"
        emailTextField.lineErrorColor = .red
        emailTextField.errorColor = .red
        emailTextField.textErrorColor = .red
        emailTextField.titleErrorColor = .red
        emailTextField.textColor = .black
        emailTextField.lineColor = .black
        emailTextField.placeholderColor = .gray
        emailTextField.titleLabel.textColor = .gray
        emailTextField.selectedTitleColor = .gray
    }
    
    private func setupPasswordTextfiled() {
        passwordTextField.placeholder = "Password"
        passwordTextField.lineErrorColor = .red
        passwordTextField.errorColor = .red
        passwordTextField.textErrorColor = .red
        passwordTextField.titleErrorColor = .red
        passwordTextField.textColor = .black
        passwordTextField.lineColor = .white
        passwordTextField.placeholderColor = .gray
        passwordTextField.titleLabel.textColor = .gray
        passwordTextField.selectedTitleColor = .gray
        updateShowHidePasswordHintImage()
        passwordTextField.isSecureTextEntry = true
        
    }
    
    @IBAction private func loggedIn(_ sender: Any) {
        
        viewModel.email = emailTextField.text
        viewModel.password = passwordTextField.text
        if let errorMessage = viewModel.emailValidation {
            emailTextField.errorMessage = errorMessage
        }
        
        if let errorMessage = viewModel.passwordValidation {
            passwordTextField.errorMessage = errorMessage
        }
        
        if viewModel.isValid {
            let tabVC = VSBaseTabBarController()
            tabVC.modalPresentationStyle = .fullScreen
            tabVC.modalTransitionStyle = .crossDissolve
            self.present(tabVC, animated: true)
        }
    }
    
    private func updateShowHidePasswordHintImage() {
        if passwordTextField.isSecureTextEntry {
            showPassword.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            showPassword.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    @IBAction private func showPassowrd(_ sender: Any) {
        updateShowHidePasswordHintImage()
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        
    }
}
