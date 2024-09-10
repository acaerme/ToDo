//
//  DataManager.swift
//  ToDo
//
//  Created by Islam Elikhanov on 09/09/2024.
//

import Foundation
import CoreData

final class DataManager: ObservableObject {
    
    static let shared = DataManager()
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "CoreData")
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
