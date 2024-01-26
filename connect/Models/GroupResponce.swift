import Foundation

struct GroupResponse: Decodable {
    let group_id: Int
    let group_name: String
    let theme: String
    let members: [Member]?
    
    enum CodingKeys: String, CodingKey {
        case group_id
        case group_name
        case theme
        case members
    }
}

struct Member: Decodable {
    let username: String
}

struct GroupData: Codable {
    let group_name: String
    let theme: String
    let max_members: Int
    let username: String
}
