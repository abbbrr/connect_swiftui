import Foundation

struct GroupModel: Decodable {
    let group_id: Int
    let group_name: String
    let theme: String
    let members: [Member]?
    let user_actions: UserActions?

    private enum CodingKeys: String, CodingKey {
        case group_id
        case group_name
        case theme
        case members
        case user_actions
    }

    struct Member: Decodable {
        let username: String?
    }

    struct UserActions: Decodable {
        let someAction: Bool
    }
}
