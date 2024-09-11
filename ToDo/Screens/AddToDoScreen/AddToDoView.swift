//
//  AddToDoView.swift
//  ToDo
//
//  Created by Islam Elikhanov on 06/09/2024.
//

import SwiftUI

struct AddToDoView: View {
    
    @ObservedObject var mainViewModel: MainViewModel // *Нужен ли tut wrapper?
    @State var localViewModel = AddToDoViewModel()
    @FocusState var isSecondTFFocused: Bool 
    @Binding var isPresented: Bool
    
    
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
                    mainViewModel.addToDo(from: localViewModel)
                    isPresented = false
                } label: {
                    Text("Add ToDo")
                }
                .disabled(localViewModel.isButtonDisabled)
            }
        }
    }
}

