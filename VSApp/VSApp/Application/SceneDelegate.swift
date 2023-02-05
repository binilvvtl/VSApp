//
//  SceneDelegate.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.overrideUserInterfaceStyle = .dark
        window.rootViewController = Storyboards.login.instantiateVC(LoginViewController.self)
        self.window = window
        window.makeKeyAndVisible()
    }
}

