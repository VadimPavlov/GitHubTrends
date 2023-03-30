//
//  Injected.swift
//  
//
//  Created by Vadym Pavlov on 29.03.2023.
//

import Foundation

@propertyWrapper
public struct Injected<Value> {
    public init() {}
    public var wrappedValue: Value {
        Resolver.shared.resolve(Value.self)
    }
}

public final class Resolver {
    private var dependencies: [String: Any] = [:]
    
    public static var shared = Resolver()
    
    public func register<T>(_ dependency: T) {
        let key = String(describing: T.self)
        dependencies[key] = dependency
    }

    public func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)
        return dependencies[key] as! T
    }
}
