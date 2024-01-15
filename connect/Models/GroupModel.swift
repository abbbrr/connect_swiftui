import Foundation

struct GroupModel: Decodable {
    let group_id: Int?
    let group_name: String
    let theme: String
    let members: [String]?
    let max_members: Int?
    
    private enum CodingKeys: String, CodingKey {
        case group_id
        case group_name
        case theme
        case members
        case max_members
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        group_id = try container.decodeIfPresent(Int.self, forKey: .group_id)
        group_name = try container.decode(String.self, forKey: .group_name)
        theme = try container.decode(String.self, forKey: .theme)
        max_members = try container.decodeIfPresent(Int.self, forKey: .max_members)

        // Обновлено здесь
        if let members = try? container.decode([String]?.self, forKey: .members) {
            self.members = members
        } else {
            self.members = []  
        }
    }
}
