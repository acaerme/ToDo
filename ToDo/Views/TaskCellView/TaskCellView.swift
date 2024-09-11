//
//  TaskCell.swift
//  ToDo
//
//  Created by Islam Elikhanov on 04/09/2024.
//

import SwiftUI

struct TaskCellView: View {
    
    @State var mainViewModel: MainViewModel
    @State var localViewModel: TaskCellViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(localViewModel.todo.title)
                        .font(.headline)
                        .foregroundStyle(.black)
                        .bold()
                        .lineLimit(1)
                        .padding(.leading, 20)
                        .strikethrough(localViewModel.todo.completed, color: .gray)
                    
                    Text(!localViewModel.todo.description.isEmpty ? localViewModel.todo.description : "No description")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                        .padding(.leading, 20)
                }
                
                Spacer()
                
                Button {
                    mainViewModel.completedButtonTappedInCell(with: localViewModel.todo.id)
                    localViewModel.completeButtonTapped()
                } label: {
                    Image(systemName: localViewModel.todo.completed ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .tint(localViewModel.todo.completed ? .blue : .gray)
                .padding(.horizontal, 20)
            }
            
            Divider()
                .padding(.horizontal)
            
            HStack {
                Text(!localViewModel.todo.date.isEmpty ? localViewModel.todo.date : "No schedule")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.gray)
                    .padding(.leading, 20)
                
                Text("\(localViewModel.todo.startTime) - \(localViewModel.todo.endTime)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .bold()
                    .foregroundStyle(.placeholder)
            }
        }
    }
}
