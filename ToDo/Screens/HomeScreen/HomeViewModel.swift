//
//  HomeViewModel.swift
//  ToDo
//
//  Created by Islam Elikhanov on 04/09/2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    private let context = DataManager.shared.container.viewContext
    
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
    
    init() {
        fetchTodos()
    }
    
    func fetchTodos() {
        do {
            let todoEntities = try context.fetch(ToDoEntity.fetchRequest())
            
            for todoEntity in todoEntities {
                let todo = ToDo(id: todoEntity.id!,
                                title: todoEntity.title!,
                                description: todoEntity.todoDescription!,
                                date: todoEntity.date!,
                                startTime: todoEntity.startTime!,
                                endTime: todoEntity.endTime!,
                                completed: todoEntity.completed)
                
                allTodos.append(todo)
            }
            
            sortTodos()
            countToDos()
            updatePresentedTodos()
        } catch {
            print("Something went wrong")
        }
    }
    
    func addToDo(from viewModel: AddToDoViewModel) {
        let todo = viewModel.getToDo()
        
        allTodos.append(todo)
        sortTodos()
        countToDos()
        updatePresentedTodos()
        
        let todoEntity = ToDoEntity(context: context)
        todoEntity.id = todo.id
        todoEntity.title = todo.title
        todoEntity.todoDescription = todo.description
        todoEntity.date = todo.date
        todoEntity.startTime = todo.startTime
        todoEntity.endTime = todo.endTime
        todoEntity.completed = todo.completed
        
        try? context.save()
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


