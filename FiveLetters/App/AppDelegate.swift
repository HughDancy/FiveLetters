//
//  AppDelegate.swift
//  FiveLetters
//
//  Created by Борис Киселев on 01.10.2024.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = AssemblyBuilder.createMainModule()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        self.window = window
        return true
    }
}

