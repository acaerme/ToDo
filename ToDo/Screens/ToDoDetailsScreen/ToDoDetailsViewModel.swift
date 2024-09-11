//
//  ToDoDetailsViewModel.swift
//  ToDo
//
//  Created by Islam Elikhanov on 10/09/2024.
//

import Foundation

struct ToDoDetailsViewModel {
    let id: UUID
    var title: String
    var description: String
    var date: Date
    var startTime: Date
    var endTime: Date
    
    var isButtonDisabled: Bool {
        title.isEmpty
    }
    
    init(id: UUID, title: String, description: String, date: String, startTime: String, endTime: String) {
        self.id = id
        self.title = title
        self.description = description
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        
        if let parsedDate = formatter.date(from: date) {
            let calendar = Calendar.current
            var components = calendar.dateComponents([.day, .month], from: parsedDate)
            components.year = calendar.component(.year, from: Date())
            self.date = calendar.date(from: components) ?? Date()
        } else {
            self.date = Date()
        }
        
        formatter.dateFormat = "h:mma"
        
        self.startTime = formatter.date(from: startTime) ?? Date()
        self.endTime = formatter.date(from: endTime) ?? Date()
    }
    
    func getToDo() -> ToDo {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "d MMMM"
        let date = formatter.string(from: date)
        
        formatter.dateFormat = "h:mma"
        let startTime = formatter.string(from: startTime)
        let endTime = formatter.string(from: endTime)
        
        let todo = ToDo(id: id,
                        title: title,
                        description: description,
                        date: date,
                        startTime: startTime,
                        endTime: endTime,
                        completed: false)
        
        return todo
    }    
}
