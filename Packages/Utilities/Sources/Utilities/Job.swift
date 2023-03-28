//
//  Job.swift
//  
//
//  Created by Vadym Pavlov on 28.03.2023.
//

import Foundation

public class Job<R>: ObservableObject {
    
    public init(result: R? = nil, isRunning: Bool = false) {
        self.result = result.map { .success($0) }
        self.isRunning = isRunning
    }
    
    @Published public var result: Result<R, Error>?
    @Published public var isRunning = false
    
    public typealias Work = () async throws -> R
    public var work: Work?
    
    public func reload() {
        result = nil
        run()
    }
    
    public func run() {
        guard let work = self.work else {
            assertionFailure("Work is not set")
            return
        }
        Task { @MainActor in
            do {
                if case .success = result {
                    return // already loaded
                }
                isRunning = true
                result = .success(try await work())
                isRunning = false
            } catch {
                isRunning = false
                result = .failure(error)
            }
        }
    }
}
