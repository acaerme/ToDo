//
//  NavigationButtonView.swift
//  ToDo
//
//  Created by Islam Elikhanov on 04/09/2024.
//

import SwiftUI

struct TopBarView: View {
    
    @ObservedObject var homeViewModel: MainViewModel
    @Binding var selectedID: Int

    var body: some View {
        HStack(spacing: 28) {
            Button  {
                selectedID = 0
            } label: {
                TopBarButton(title: "All", number: homeViewModel.allTodosCount, isSelected: selectedID == 0 ? true : false)
            }
            
            Divider()
                .frame(height: 20)
            
            Button  {
                selectedID = 1
            } label: {
                TopBarButton(title: "Open", number: homeViewModel.openTodosCount, isSelected: selectedID == 1 ? true : false)
            }
            
            Button  {
                selectedID = 2
            } label: {
                TopBarButton(title: "Closed", number: homeViewModel.closedTodosCount, isSelected: selectedID == 2 ? true : false)
            }
        }
    }
}

struct TopBarButton: View {
    
    let title: String
    var number: Int
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
    TopBarView(homeViewModel: MainViewModel(), selectedID: .constant(0))
}
