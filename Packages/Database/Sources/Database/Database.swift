import CoreData

public class Database {
    let modelName = "GitHubModel"
    public let container: NSPersistentContainer
    
    public var mainContext: NSManagedObjectContext { container.viewContext }
    private lazy var context = container.newBackgroundContext()

    public init() {
        if let url = Bundle.module.url(forResource: modelName, withExtension: "momd"),
           let model = NSManagedObjectModel(contentsOf: url) {
            container = NSPersistentContainer(name: "GitHub", managedObjectModel: model)
        } else {
            container = NSPersistentContainer(name: modelName)
        }
        mainContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { desc, error in
            if let error = error {
                // TODO: handle error somehow?
                print("Datbase initialization error: \(error.localizedDescription)")
            }
        }
    }
        
    public func addToFavorites(repository: Repository) async throws {
        try await context.perform { [unowned self] in
            let repo = CDRepository(context: self.context)
            repo.fill(with: repository)
            try self.context.save()
        }
    }
    
    public func removeFromFavorites(repository: Repository) async throws {
        try await context.perform { [unowned self] in
            if let repo = try self.repository(for: repository.id) {
                self.context.delete(repo)
                try self.context.save()
            }
        }
    }
    
    public func isFavorite(repository: Repository) async throws -> Bool {
        try await context.perform {
            try self.repository(for: repository.id) != nil
        }
    }
    
    func repository(for id: Int) throws -> CDRepository? {
        let request = CDRepository.fetchRequest()
        request.fetchBatchSize = 1
        request.predicate = NSPredicate(format: "%K == \(id)", #keyPath(CDRepository.intID))
        return try context.fetch(request).first
    }
}
