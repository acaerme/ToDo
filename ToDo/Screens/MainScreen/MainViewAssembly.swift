//
//  ModuleCreator.swift
//  ToDo
//
//  Created by Islam Elikhanov on 11/09/2024.
//

import Foundation
import SwiftUI

struct MainViewAssembly {
    static func prepareMainView() -> some View {
        let networkManager = AutoInject<NetworkManager>().wrappedValue
        let viewModel = MainViewModel(networkManager: networkManager)
        let mainView = MainView(viewModel: viewModel)
        return mainView
    }
}
