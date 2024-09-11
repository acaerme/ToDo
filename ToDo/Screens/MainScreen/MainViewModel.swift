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
    
    @Published var selectedID = 0 { didSet { updatePresentedTodos() } }
    @Published var presentedTodos: [ToDo] = []
    @Published var isPresentingSheet = false
    @Published var allTodosCount = 0
    @Published var openTodosCount = 0
    @Published var closedTodosCount = 0
    lazy var date = getDate()
    var allTodos: [ToDo] = []
    var openTodos: [ToDo] = []
    var closedTodos: [ToDo] = []
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        
        fetchTodos()
        
        //        if !UserDefaults.standard.bool(forKey: "madeNetworkCall") {
        Task {
            try await handleNetworkResponse(response: networkManager.fetchData())
            UserDefaults.standard.setValue(true, forKey: "madeNetworkCall")
        }
        //        }
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
        
        sortTodos()
        countToDos()
        updatePresentedTodos()
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.deleteToDoFromCoreData(id: id)
        }
    }
    
    
    
    func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        
        return formatter.string(from: date)
    }
    
    func completedButtonTappedInCell(with id: UUID) {
        for index in allTodos.indices {
            if allTodos[index].id == id {
                allTodos[index].completed.toggle()
            }
        }
        
        sortTodos()
        countToDos()
        updatePresentedTodos()
        
        let request = ToDoEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        do {
            let result = try context.fetch(request)
            result[0].completed.toggle()
            try context.save()
        } catch {
            print("Something went wrong")
        }
    }
    
    func updateToDo(from viewModel: ToDoDetailsViewModel) {
        let todo = viewModel.getToDo()
        
        allTodos = allTodos.map { $0.id == todo.id ? todo : $0 }
        
        sortTodos()
        countToDos()
        updatePresentedTodos()
        
        let request = ToDoEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", todo.id as CVarArg)
        request.predicate = predicate
        
        do {
            let result = try context.fetch(request)
            result[0].title = todo.title
            result[0].todoDescription = todo.description
            result[0].date = todo.date
            result[0].startTime = todo.startTime
            result[0].endTime = todo.endTime
            try context.save()
        } catch {
            print("Something went wrong")
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
        
        sortTodos()
        countToDos()
        updatePresentedTodos()
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
}


