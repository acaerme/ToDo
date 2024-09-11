//
//  Container.swift
//  ToDo
//
//  Created by Islam Elikhanov on 11/09/2024.
//

import Foundation
import Swinject
import SwinjectAutoregistration

extension Container {
    static var rootContainer = Container(defaultObjectScope: .transient)
    
    static func prepareConfigValues() {
        let container = rootContainer
        
        container.register(String.self, name: "network_service_url") { _ in
            "https://dummyjson.com/todos"
        }
    }
    
    static func prepareRootContainer() {
        let container = rootContainer
        prepareConfigValues()
        container.register(NetworkManager.self) { resolver in
            let url = resolver.resolve(String.self, name: "network_service_url")!
            
            return NetworkManagerIMP(url: url)
        }.inObjectScope(.container)
    }
}
