import Foundation

class GroupViewModel: ObservableObject {
    @Published var group: GroupModel?

    func createGroup(groupName: String, theme: String, maxMembers: Int, username:Any ,completion: @escaping (Result<Int, Error>) -> Void) {
        GroupServer.shared.createGroup(groupName: groupName, theme: theme, maxMembers: maxMembers, username: username) { result in
            switch result {
            case .success(let createdGroup):
                if let groupID = createdGroup?.group_id {
                    DispatchQueue.main.async {
                        self.group = createdGroup
                        completion(.success(groupID))
                    }
                } else {
                    let error = NSError(domain: "YourAppDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get group_id"])
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Failed to create group: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
