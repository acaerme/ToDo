//
//  HomeViewModel.swift
//  ToDo
//
//  Created by Islam Elikhanov on 04/09/2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var selectedID = 0 {
        didSet { updatePresentedTodos() }
    }
    
    @Published var presentedTodos: [ToDo] = []
    @Published var isPresentingSheet = false
    @Published var allTodosCount = 0
    @Published var openTodosCount = 0
    @Published var closedTodosCount = 0
    lazy var date = getDate()
    var allTodos: [ToDo] = []
    var openTodos: [ToDo] = []
    var closedTodos: [ToDo] = []
    
    func addToDo(from viewModel: AddToDoViewModel) {
        allTodos.append(viewModel.getToDo())
        sortTodos()
        countToDos()
        updatePresentedTodos()
    }
    
    func sortTodos() {
        for todo in allTodos {
            if !todo.completed {
                openTodos.append(todo)
            } else {
                closedTodos.append(todo)
            }
        }
    }
    
    func countToDos() {
        allTodosCount = allTodos.count
        openTodosCount = openTodos.count
        closedTodosCount = closedTodos.count
    }
    
    func updatePresentedTodos() {
        switch selectedID {
        case 0:
            presentedTodos = allTodos
        case 1:
            presentedTodos = openTodos
        case 2:
            presentedTodos = closedTodos
        default:
            return
        }
    }
    
    func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        
        return formatter.string(from: date)
    }
    
}


