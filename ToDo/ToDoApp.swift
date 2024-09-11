//
//  ToDoApp.swift
//  ToDo
//
//  Created by Islam Elikhanov on 03/09/2024.
//

import SwiftUI
import Swinject

@main
struct ToDoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainViewAssembly.prepareMainView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Код инициализации приложения
        Container.prepareRootContainer()
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Приложение входит в фоновый режим
        print("Приложение вошло в фоновый режим")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Приложение перешло в фоновый режим
        print("Приложение перешло в фоновый режим")
    }

    // Добавьте другие методы AppDelegate при необходимости
}
