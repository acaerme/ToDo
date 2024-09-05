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
                    
                    Text("Wednesday, 11 May")
                        .bold()
                        .foregroundStyle(.gray)
                }
                
                Button {
                    print("Tap")
                } label: {
                    Label("New Task", systemImage: "plus")
                }
                .buttonStyle(.bordered)
                .tint(.blue)
                .controlSize(.large)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding()
            
            TopBarView(selectedID: $viewModel.selectedID)
            
            ScrollView {
                ForEach(MockData().tasks) { task in
                    TaskCell(isDone: task.completed)
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .padding()
        }
        .ignoresSafeArea(edges: .bottom)
        .background(Color("backgroundGray"))
    }
}

struct MockData {
    let tasks = [
        Task(id2: 0, todo: "Clean up my room", completed: false),
        Task(id2: 0, todo: "Clean up my room", completed: false),
        Task(id2: 0, todo: "Clean up my room", completed: false),
        Task(id2: 0, todo: "Clean up my room", completed: false),
        Task(id2: 0, todo: "Clean up my room", completed: false),
        Task(id2: 0, todo: "Clean up my room", completed: false)
    ]
}

struct Task: Identifiable {
    let id = UUID()
    let id2: Int
    let todo: String
    let completed: Bool
}

#Preview {
    HomeView()
}
