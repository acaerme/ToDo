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
                    Text(localViewModel.title)
                        .font(.headline)
                        .foregroundStyle(.black)
                        .bold()
                        .lineLimit(1)
                        .padding(.leading, 20)
                        .strikethrough(localViewModel.completed, color: .gray)
                    
                    Text(localViewModel.descriptionString)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                        .padding(.leading, 20)
                }
                
                Spacer()
                
                Button {
                    mainViewModel.completedButtonTappedInCell(with: localViewModel.id)
                    localViewModel.completeButtonTapped()
                } label: {
                    Image(systemName: localViewModel.completeButtonImage)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .tint(localViewModel.completed ? .blue : .gray)
                .padding(.horizontal, 20)
            }
            
            Divider()
                .padding(.horizontal)
            
            HStack {
                Text(localViewModel.dateString)
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.gray)
                    .padding(.leading, 20)
                
                Text("\(localViewModel.startTime) - \(localViewModel.endTime)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .bold()
                    .foregroundStyle(.gray)
            }
        }
    }
}
