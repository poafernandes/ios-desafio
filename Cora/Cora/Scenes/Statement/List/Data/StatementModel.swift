import Foundation

struct StatementModel: Decodable {
    let results: [ResultItem],
        itemsTotal: Int
}

struct ResultItem: Decodable {
    let items: [TransactionItem],
        date: String
}

struct TransactionItem: Decodable {
    let id: String,
        description: String,
        label: String,
        entry: String,
        amount: Int,
        name: String,
        dateEvent: String,
        status: String
}
