//
//  AppDelegate.swift
//  Cam-Gallery
//
//  Created by Kyle Lee on 6/18/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

import Amplify
import AmplifyPlugins
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        do {
            let models = AmplifyModels()
            try Amplify.add(
                plugin: AWSDataStorePlugin(modelRegistration: models)
            )
            try Amplify.add(
                plugin: AWSAPIPlugin(modelRegistration: models)
            )

            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())

            try Amplify.configure()

            print("Successfully initialized Amplify")

        } catch {
            print("Could not initialize Amplify - \(error)")
        }
        
        return true
    }

}

