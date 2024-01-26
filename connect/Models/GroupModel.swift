import Foundation

//struct GroupModel: Decodable {
//    let group_id: Int
//    let group_name: String
//    let theme: String
//    let members: [Member]?
//
//    private enum CodingKeys: String, CodingKey {
//        case group_id
//        case group_name
//        case theme
//        case members
//    }
//
//    struct Member: Decodable {
//        let username: String
//    }
//}

struct GroupModel: Decodable {
    let group_id: Int
    let group_name: String
    let theme: String
    let members: [Member]

    struct Member: Decodable {
        let username: String
    }
}

