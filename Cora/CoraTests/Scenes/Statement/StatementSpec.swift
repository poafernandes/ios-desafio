import Foundation
import Testing

@testable import Cora

@Suite class StatementSpec {
    let sut = StatementViewModel()
    
    @Test func didLoad() {
        sut.reloadItems = {
            #expect(!self.sut.items.isEmpty)
            #expect(self.sut.sections.first == "2024-02-01")
        }
        sut.didLoad()
    }
}
