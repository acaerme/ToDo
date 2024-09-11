//
//  NetworkResponse.swift
//  ToDo
//
//  Created by Islam Elikhanov on 11/09/2024.
//

import Foundation

struct NetworkResponse: Codable {
    let todos: [ToDoNetworkObject]
}

struct ToDoNetworkObject: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}
