import CoraClientInterfaces
import Foundation

final class StatementService {
    @Inject
    var apiClient: ApiClientProtocol
    
    func fetchStatements() async -> StatementModel? {
        do {
            return try await apiClient.fetch(request: StatementRequest())
        } catch {
            return nil
        }
    }
}
