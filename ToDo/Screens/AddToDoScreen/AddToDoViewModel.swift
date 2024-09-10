//
//  AddToDoViewModel.swift
//  ToDo
//
//  Created by Islam Elikhanov on 08/09/2024.
//

import SwiftUI

struct AddToDoViewModel {
    var title = ""
    var description = ""
    var date = Date()
    var startTime = Date()
    var endTime = Date()
    
    func getToDo() -> ToDo  {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "d MMMM"
        let date = formatter.string(from: date)
        
        formatter.dateFormat = "h:mma"
        let startTime = formatter.string(from: startTime)
        let endTime = formatter.string(from: endTime)
        
        let todo = ToDo(id: UUID(),
                        title: title,
                        description: description,
                        date: date,
                        startTime: startTime,
                        endTime: endTime,
                        completed: false)
        
        return todo
    }
    
    func checkButton() -> Bool {
        title.isEmpty
    }
}
