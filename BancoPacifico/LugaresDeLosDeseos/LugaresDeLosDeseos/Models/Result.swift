import Foundation

// el server puede enviar muchas mas variables pero yo solo escribo las que necesito
struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageId: Int
    let title: String
    let terms: [String: [String]]?
}
