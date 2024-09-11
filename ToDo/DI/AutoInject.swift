//
//  AutoInject.swift
//  ToDo
//
//  Created by Islam Elikhanov on 11/09/2024.
//

import Foundation
import Swinject

@propertyWrapper
public final class AutoInject<Value> {
    public private(set) var wrappedValue: Value

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }

    public init() {
        let container = Container.rootContainer.synchronize()

        guard let value = container.resolve(Value.self) else {
            fatalError("Could not resolve non-optional \(Value.self)")
        }

        wrappedValue = value
    }
}
