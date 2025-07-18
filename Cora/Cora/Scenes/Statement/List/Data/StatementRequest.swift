import CoraClientInterfaces
import Foundation

struct StatementRequest: RequestProtocol {
    var path: String { EnvironmentURL.statementList }
    var body: Encodable?
    var headers: [String: String] = [:]
    var method: RequestMethod { .get }
    var encoding: RequestEncoding { .json }
}
