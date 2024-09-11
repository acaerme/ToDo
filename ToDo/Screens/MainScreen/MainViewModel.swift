//
//  HomeViewModel.swift
//  ToDo
//
//  Created by Islam Elikhanov on 04/09/2024.
//

import Foundation
import SwinjectAutoregistration

final class MainViewModel: ObservableObject {
    
    private let context = DataManager.shared.container.viewContext
    private let networkManager: NetworkManager
    
    @Published var selectedID = 0 { didSet { 
        DispatchQueue.main.async { [weak self] in
            self?.updatePresentedTodos()
        }
    } }
    
    @Published var presentedTodos: [ToDo] = []
    @Published var isPresentingSheet = false
    @Published var allTodosCount = 0
    @Published var openTodosCount = 0
    @Published var closedTodosCount = 0
    var dateString: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        
        return formatter.string(from: date)
    }
    var allTodos: [ToDo] = []
    var openTodos: [ToDo] = []
    var closedTodos: [ToDo] = []
    
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        
        fetchTodos()
        
        if !UserDefaults.standard.bool(forKey: "madeNetworkCall") {
            Task {
                let response = try await networkManager.fetchData()
                handleNetworkResponse(response: response)
                UserDefaults.standard.setValue(true, forKey: "madeNetworkCall")
            }
        }
    }
    
    func sortTodos() {
        openTodos = []
        closedTodos = []
        
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
    
    func fetchTodos() {
        do {
            let todoEntities = try context.fetch(ToDoEntity.fetchRequest())
            
            for todoEntity in todoEntities {
                let todo = ToDo(id: todoEntity.id ?? UUID(),
                                title: todoEntity.title ?? "",
                                description: todoEntity.todoDescription ?? "",
                                date: todoEntity.date ?? "",
                                startTime: todoEntity.startTime ?? "",
                                endTime: todoEntity.endTime ?? "",
                                completed: todoEntity.completed)
                
                allTodos.append(todo)
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.sortTodos()
                self?.countToDos()
                self?.updatePresentedTodos()
            }
        } catch {
            print("Something went wrong")
        }
    }
    
    func addToDo(from viewModel: AddToDoViewModel) {
        let todo = viewModel.getToDo()
        
        allTodos.append(todo)
        
        DispatchQueue.main.async { [weak self] in
            self?.sortTodos()
            self?.countToDos()
            self?.updatePresentedTodos()
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.addToDoToCoreData(todo: todo)
        }
    }
    
    func deleteToDo(with id: UUID) {
        for index in allTodos.indices {
            if allTodos[index].id == id {
                allTodos.remove(at: index)
                break
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.sortTodos()
            self?.countToDos()
            self?.updatePresentedTodos()
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.deleteToDoFromCoreData(id: id)
        }
    }
    
    func updateToDo(from viewModel: ToDoDetailsViewModel) {
        let todo = viewModel.getToDo()
        
        allTodos = allTodos.map { $0.id == todo.id ? todo : $0 }
        
        DispatchQueue.main.async { [weak self] in
            self?.sortTodos()
            self?.countToDos()
            self?.updatePresentedTodos()
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.updateToDoInCoreData(todo: todo)
        }
    }

    func completedButtonTappedInCell(with id: UUID) {
        for index in allTodos.indices {
            if allTodos[index].id == id {
                allTodos[index].completed.toggle()
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.sortTodos()
            self?.countToDos()
            self?.updatePresentedTodos()
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.handleCompleteButtonTapInCoreData(id: id)
        }
    }
    
    func handleNetworkResponse(response: NetworkResponse) {
        var tempTodos: [ToDo] = []
        
        for todoResponse in response.todos {
            tempTodos.append(ToDo(id: UUID(),
                                  title: todoResponse.todo,
                                  description: "",
                                  date: "",
                                  startTime: "",
                                  endTime: "",
                                  completed: todoResponse.completed))
        }
        
        for todo in tempTodos {
            allTodos.append(todo)
            
            DispatchQueue.global(qos: .background).async { [weak self] in
                self?.addToDoToCoreData(todo: todo)
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.sortTodos()
            self?.countToDos()
            self?.updatePresentedTodos()
        }
    }
    
    private func addToDoToCoreData(todo: ToDo) {
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
    
    private func deleteToDoFromCoreData(id: UUID) {
        let request = ToDoEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let result = try context.fetch(request)
            context.delete(result[0])
            try context.save()
        } catch {
            print("Something went wrong")
        }
    }
    
    private func updateToDoInCoreData(todo: ToDo) {
        let request = ToDoEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", todo.id as CVarArg)
        request.predicate = predicate
        
        do {
            let result = try context.fetch(request)
            guard let todoEntity = result.first else { return }
            todoEntity.title = todo.title
            todoEntity.todoDescription = todo.description
            todoEntity.date = todo.date
            todoEntity.startTime = todo.startTime
            todoEntity.endTime = todo.endTime
            try context.save()
        } catch {
            print("Something went wrong")
        }
    }
    
    private func handleCompleteButtonTapInCoreData(id: UUID) {
        let request = ToDoEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let result = try context.fetch(request)
            guard let todoEntity = result.first else { return }
            todoEntity.completed.toggle()
            try context.save()
        } catch {
            print("Something went wrong")
        }
    }
}


