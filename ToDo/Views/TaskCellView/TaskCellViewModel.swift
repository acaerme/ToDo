//
//  TaskCellViewModel.swift
//  ToDo
//
//  Created by Islam Elikhanov on 08/09/2024.
//

import Foundation
import SwiftUI

struct TaskCellViewModel {
    
    let id: UUID
    let title: String
    let description: String
    let date: String
    let startTime: String
    let endTime: String
    var completed: Bool
    
    var descriptionString: String {
        !description.isEmpty ? description : "No description"
    }
    
    var completeButtonImage: String {
        completed ? "checkmark.circle.fill" : "circle"
    }
    
    var dateString: String {
        !date.isEmpty ? date : "No schedule"
    }
    
    init(todo: ToDo) {
        self.id = todo.id
        self.title = todo.title
        self.description = todo.description
        self.date = todo.date
        self.startTime = todo.startTime
        self.endTime = todo.endTime
        self.completed = todo.completed
    }
    
    mutating func completeButtonTapped() {
        completed.toggle()
    }
}
