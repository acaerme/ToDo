//
//  ContentView.swift
//  ToDo
//
//  Created by Islam Elikhanov on 03/09/2024.
//

import SwiftUI
import Swinject





struct MainView: View {
    
    @ObservedObject private var mainViewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.mainViewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 40) {
                    VStack(alignment: .leading) {
                        Text("Today's Task")
                            .lineLimit(1)
                            .font(.title)
                            .bold()
                        
                        Text(mainViewModel.dateString)
                            .lineLimit(1)
                            .minimumScaleFactor(0.6)
                            .bold()
                            .foregroundStyle(.gray)
                    }
                    
                    Button {
                        mainViewModel.isPresentingSheet = true
                    } label: {
                        Label("New Task", systemImage: "plus")
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .controlSize(.large)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding()
                
                TopBarView(mainViewModel: mainViewModel, selectedID: $mainViewModel.selectedID)
                
                ScrollView {
                    ForEach(mainViewModel.presentedTodos) { todo in
                        NavigationLink(value: todo) {
                            TaskCellView(mainViewModel: mainViewModel,
                                         localViewModel: TaskCellViewModel(todo: todo))
                                .padding()
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                }
                .padding()
            }
            .ignoresSafeArea(edges: .bottom)
            .background(Color("backgroundGray"))
            .sheet(isPresented: $mainViewModel.isPresentingSheet) {
                AddToDoView(mainViewModel: mainViewModel,
                            isPresented: $mainViewModel.isPresentingSheet)
            }
            .navigationDestination(for: ToDo.self) { todo in
                ToDoDetailsView(mainViewModel: mainViewModel,
                                localViewModel: ToDoDetailsViewModel(
                                                                id: todo.id,
                                                                title: todo.title,
                                                                description: todo.description,
                                                                date: todo.date,
                                                                startTime: todo.startTime,
                                                                endTime: todo.endTime))
            }
        }
    }
}
