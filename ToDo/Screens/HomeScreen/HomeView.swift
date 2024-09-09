//
//  ContentView.swift
//  ToDo
//
//  Created by Islam Elikhanov on 03/09/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            HStack(spacing: 40) {
                VStack {
                    Text("Today's Task")
                        .font(.title)
                        .bold()
                    
                    Text(viewModel.date)
                        .bold()
                        .foregroundStyle(.gray)
                }
                
                Button {
                    viewModel.isPresentingSheet = true
                } label: {
                    Label("New Task", systemImage: "plus")
                }
                .buttonStyle(.bordered)
                .tint(.blue)
                .controlSize(.large)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding()
            
            TopBarView(homeViewModel: viewModel, selectedID: $viewModel.selectedID)
            
            ScrollView {
                ForEach(viewModel.todos) { todo in
                    TaskCellView(viewModel: TaskCellViewModel(todo: todo))
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .padding()
        }
        .ignoresSafeArea(edges: .bottom)
        .background(Color("backgroundGray"))
        .sheet(isPresented: $viewModel.isPresentingSheet) {
            AddToDoView(homeViewModel: viewModel, isPresented: $viewModel.isPresentingSheet)
        }
    }
}

#Preview {
    HomeView()
}
