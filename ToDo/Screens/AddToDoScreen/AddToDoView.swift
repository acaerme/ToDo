//
//  AddToDoView.swift
//  ToDo
//
//  Created by Islam Elikhanov on 06/09/2024.
//

import SwiftUI

struct AddToDoView: View {
    
    var homeViewModel: HomeViewModel
    @State var addToDoViewModel = AddToDoViewModel()
    @FocusState var isSecondTFFocused: Bool // TODO: Should I move it to viewModel?
    @Binding var isPresented: Bool
    
    
    var body: some View {
        VStack {
            Form {
                Section("New ToDo") {
                    TextField("Title", text: $addToDoViewModel.title)
                        .onSubmit {
                            isSecondTFFocused = true
                        }
                    
                    TextField("Description", text: $addToDoViewModel.description)
                        .focused($isSecondTFFocused)
                }
                
                Section("Schedule ToDo") {
                    DatePicker("Pick a date",
                               selection: $addToDoViewModel.date,
                               displayedComponents: [.date])
                    
                    DatePicker("Start", 
                               selection: $addToDoViewModel.startTime,
                               displayedComponents: [.hourAndMinute])
                    
                    DatePicker("End", 
                               selection: $addToDoViewModel.endTime,
                               displayedComponents: [.hourAndMinute])
                }
            }
            
            Button {
                homeViewModel.addToDo(from: addToDoViewModel)
                isPresented = false
            } label: {
                Text("Tap me")
            }
            .disabled(addToDoViewModel.checkButton())
        }
    }
}

#Preview {
    AddToDoView(homeViewModel: HomeViewModel(), isPresented: .constant(true))
}
