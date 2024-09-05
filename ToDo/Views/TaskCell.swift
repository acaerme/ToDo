//
//  TaskCell.swift
//  ToDo
//
//  Created by Islam Elikhanov on 04/09/2024.
//

import SwiftUI

struct TaskCell: View {
    
    @State var isDone: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Water the plants")
                        .font(.headline)
                        .bold()
                        .lineLimit(1)
                        .padding(.leading, 20)
                        .strikethrough(isDone, color: .gray)
                    
                    Text("Description of how to do it")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                        .padding(.leading, 20)
                }
                
                Spacer()
                
                Button {
                    isDone.toggle()
                } label: {
                    Image(systemName: isDone ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .tint(isDone ? .blue : .gray)
                .padding(.horizontal, 20)
            }
            
            Divider()
                .padding(.horizontal)
            
            HStack {
                Text("Today")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.gray)
                    .padding(.leading, 20)
                
                Text("10:00 PM - 11:45 PM")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.placeholder)
            }
        }
    }
}

#Preview {
    TaskCell(isDone: false)
}
