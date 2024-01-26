import Foundation
import Alamofire

private let url = "http://127.0.0.1:5000/api/"

class GroupServer: ObservableObject {
    static let shared = GroupServer()
    private init() {}
    
    
    func creategroup(groupName:String,  theme: String, maxMembers: Int, username: String, completion: @escaping (Result<GroupResponse, Error>) -> Void) {
        guard let url = URL(string: "\(url)/create_group") else{
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let groupData = GroupData(group_name: groupName, theme: theme, max_members: maxMembers, username: username)
        
        AF.request(url, method: .post, parameters: groupData, encoder: JSONParameterEncoder.default)
            .responseDecodable(of:GroupResponse.self){ response in
                switch response.result{
                case .success(let groupResponse):
                    completion(.success(groupResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
