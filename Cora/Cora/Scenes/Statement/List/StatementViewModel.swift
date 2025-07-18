import Foundation

final class StatementViewModel {
    
    let service = StatementService()
    
    var reloadItems: (() -> Void)!
    var items: [[StatementItemViewModel]] = []
    var sections: [String] = []
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }()
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    func didLoad() {
        Task {
            let items = await service.fetchStatements()
            handleResult(items!)
        }
    }
    
    func handleResult(_ statementItems: StatementModel) {
        let isoDateFormatter = ISO8601DateFormatter()
        
        sections = statementItems.results.map { $0.date }
        items = statementItems.results.compactMap { resultItem in
            resultItem.items.map { item in
                let value = currencyFormatter.string(from: NSNumber(value: Double(item.amount) / 100.0))!
                let time = isoDateFormatter.date(from: item.dateEvent).map { timeFormatter.string(from: $0) }!
                
                return StatementItemViewModel(
                    value: value,
                    description: item.label,
                    receiver: item.name,
                    time: time,
                    icon: nil
                )
            }
        }
        
        Task { @MainActor in
            reloadItems()
        }
    }
}
