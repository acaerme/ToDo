//
//  HomeViewModel.swift
//  ToDo
//
//  Created by Islam Elikhanov on 04/09/2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var selectedID = 0
    @Published var todos: [ToDo] = []
    @Published var isPresentingSheet = false
    @Published var allToDos = 0
    @Published var openToDos = 0
    @Published var closedToDos = 0
    lazy var date = getDate()
    
    func addToDo(from viewModel: AddToDoViewModel) {
        todos.append(viewModel.getToDo())
        
        sortToDos()
    }
    
    func sortToDos() {
        allToDos = todos.count
        openToDos = 0
        closedToDos = 0
        
        for todo in todos {
            if !todo.completed {
                openToDos += 1
            } else {
                closedToDos += 1
            }
        }
    }
    
    func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        
        return formatter.string(from: date)
    }
}


