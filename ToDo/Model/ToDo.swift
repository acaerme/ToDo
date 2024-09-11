//
//  ToDo.swift
//  ToDo
//
//  Created by Islam Elikhanov on 08/09/2024.
//

import Foundation

struct ToDo: Identifiable, Hashable {
    let id: UUID
    let title: String
    let description: String
    let date: String
    let startTime: String
    let endTime: String
    var completed: Bool
}
