import Foundation

struct GroupResponse: Decodable {
    let message: String
    let groupID: Int
    let groupName: String
    let theme: String
    let members: [Member]
}

struct Member: Decodable {
    let username: String
    let status: String
}
