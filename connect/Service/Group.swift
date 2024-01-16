import Foundation
import Alamofire

private let url = "http://127.0.0.1:5000/api/"

class GroupServer: ObservableObject {
    static let shared = GroupServer()
    private init() {}

    func createGroup(groupName: String, theme: String, maxMembers: Int, completion: @escaping (Result<GroupModel?, Error>) -> Void) {
        let endpoint = "\(url)create_group"

        let parameters: [String: Any] = [
            "group_name": groupName,
            "theme": theme,
            "max_members": maxMembers
        ]

        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(GroupModel.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        print("Error decoding response: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Error creating group: \(error.localizedDescription)")

                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Response data: \(utf8Text)")
                    }

                    completion(.failure(error))
                }
            }
    }

    enum MyError: Error {
        case dataMissing
    }
}
