//
//  SceneDelegate.swift
//  Cam-Gallery
//
//  Created by Kyle Lee on 6/18/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        let navController = UINavigationController(rootViewController: GalleryViewController())
        navController.navigationBar.prefersLargeTitles = true
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }
}

