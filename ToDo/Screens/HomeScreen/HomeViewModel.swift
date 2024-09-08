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
    
    func addToDo(from viewModel: AddToDoViewModel) {
        todos.append(viewModel.getToDo())
    }
}


