//
//  NetworkManager.swift
//  ToDo
//
//  Created by Islam Elikhanov on 11/09/2024.
// 

import Foundation

protocol NetworkManager {
    func fetchData() async throws -> NetworkResponse
}

final class NetworkManagerIMP: NetworkManager {
    let urlString: String
    
    init(url: String) {
        self.urlString = url
    }
    
    func fetchData() async throws -> NetworkResponse {
        guard let url = URL(string: urlString) else {
            throw NetworkErrors.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkErrors.requestFailed
        }
        
        guard response.statusCode == 200 else {
            throw NetworkErrors.badResponse
        }
        
        do {
            let netResponse = try JSONDecoder().decode(NetworkResponse.self, from: data)
            return netResponse
        } catch {
            throw NetworkErrors.failedToDecode
        }
    }
}
