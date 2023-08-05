//
//  SceneDelegate.swift
//  Coople_Krushev
//
//  Created by Krushev on 8/5/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let firstVC = ViewController()

        let navigationController = UINavigationController()
        navigationController.pushViewController(firstVC, animated: false)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
