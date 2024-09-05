//
//  NavigationButtonView.swift
//  ToDo
//
//  Created by Islam Elikhanov on 04/09/2024.
//

import SwiftUI

struct TopBarView: View {
    
    @Binding var selectedID: Int

    var body: some View {
        HStack(spacing: 28) {
            Button  {
                selectedID = 0
            } label: {
                TopBarButton(title: "All", number: 35, isSelected: selectedID == 0 ? true : false)
            }
            
            Divider()
                .frame(height: 20)
            
            Button  {
                selectedID = 1
            } label: {
                TopBarButton(title: "Open", number: 14, isSelected: selectedID == 1 ? true : false)
            }
            
            Button  {
                selectedID = 2
            } label: {
                TopBarButton(title: "Closed", number: 19, isSelected: selectedID == 2 ? true : false)
            }
        }
    }
}

struct TopBarButton: View {
    
    let title: String
    @State var number: Int
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .bold()
                .foregroundStyle(isSelected ? .blue : .gray)
            
            Text("\(number)")
                .font(.system(size: 12))
                .bold()
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .foregroundStyle(.white)
                .background(isSelected ? .blue : .gray)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

#Preview {
    TopBarView(selectedID: .constant(1))
}
