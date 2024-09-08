//
//  TaskCell.swift
//  ToDo
//
//  Created by Islam Elikhanov on 04/09/2024.
//

import SwiftUI

struct TaskCellView: View {
    
    @State var viewModel: TaskCellViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(viewModel.todo.title)
                        .font(.headline)
                        .bold()
                        .lineLimit(1)
                        .padding(.leading, 20)
                        .strikethrough(viewModel.todo.completed, color: .gray)
                    
                    Text(!viewModel.todo.description.isEmpty ? viewModel.todo.description : "No description")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                        .padding(.leading, 20)
                }
                
                Spacer()
                
                Button {
                    viewModel.todo.completed.toggle()
                } label: {
                    Image(systemName: viewModel.todo.completed ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .tint(viewModel.todo.completed ? .blue : .gray)
                .padding(.horizontal, 20)
            }
            
            Divider()
                .padding(.horizontal)
            
            HStack {
                Text(viewModel.todo.date)
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.gray)
                    .padding(.leading, 20)
                
                Text("\(viewModel.todo.startTime) - \(viewModel.todo.endTime)")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.placeholder)
            }
        }
    }
}
