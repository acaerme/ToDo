//
//  ToDoDetailsView.swift
//  ToDo
//
//  Created by Islam Elikhanov on 10/09/2024.
//

import SwiftUI

struct ToDoDetailsView: View {
    
    var mainViewModel: MainViewModel
    @State var localViewModel: ToDoDetailsViewModel
    @FocusState var isSecondTFFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Form {
                Section("New ToDo") {
                    TextField("Title", text: $localViewModel.title)
                        .onSubmit {
                            isSecondTFFocused = true
                        }
                    
                    TextField("Description", text: $localViewModel.description)
                        .focused($isSecondTFFocused)
                }
                
                Section("Schedule ToDo") {
                    DatePicker("Pick a date",
                               selection: $localViewModel.date,
                               displayedComponents: [.date])
                    
                    DatePicker("Start",
                               selection: $localViewModel.startTime,
                               displayedComponents: [.hourAndMinute])
                    
                    DatePicker("End",
                               selection: $localViewModel.endTime,
                               displayedComponents: [.hourAndMinute])
                }
                
                Button {
                    mainViewModel.updateToDo(from: localViewModel)
                    dismiss()
                } label: {
                    Text("Save Changes")
                }
                .disabled(localViewModel.checkButton())
                
                Button {
                    mainViewModel.deleteToDo(with: localViewModel.id)
                    dismiss()
                } label: {
                    Text("Delete ToDo")
                }
                .disabled(localViewModel.checkButton())
                .foregroundStyle(.red)
            }
        }
    }
}
