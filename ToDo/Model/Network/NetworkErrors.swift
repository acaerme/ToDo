//
//  NetworkErrors.swift
//  ToDo
//
//  Created by Islam Elikhanov on 11/09/2024.
//

import Foundation

enum NetworkErrors: Error {
    case invalidUrl
    case requestFailed
    case badResponse
    case failedToDecode
    case unknownError
}
