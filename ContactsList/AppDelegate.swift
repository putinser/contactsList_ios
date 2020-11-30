//
//  AppDelegate.swift
//  ContactsList
//
//  Created by ios on 11/30/20.
//  Copyright © 2020 ios. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
       
       func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           
           UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
           UINavigationBar.appearance().tintColor = .black
           UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
           UINavigationBar.appearance().isTranslucent = false
           
           let control = ListContactsViewController.storyboardInstance
           let navController = UINavigationController(rootViewController: control)
           let frame = UIScreen.main.bounds
           self.window = UIWindow(frame: frame)
           self.window?.rootViewController = navController
           self.window!.makeKeyAndVisible()
           
           return true
       }


}

