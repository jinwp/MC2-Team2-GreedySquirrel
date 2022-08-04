//
//  campairApp.swift
//  campair
//
//  Created by Shin Jae Ung on 2022/06/10.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        Thread.sleep(forTimeInterval: 1)
        return true
    }
}

@main
struct CampairApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            TabbarView()
        }
    }
}
