import Foundation

class GroupViewModel: ObservableObject {
    @Published var group: GroupModel?
    @Published var groupID: String?
    @Published var groupName: String?
    @Published var theme: String?

    func createGroup(groupName: String, theme: String, maxMembers: Int) {
        GroupServer.shared.createGroup(groupName: groupName, theme: theme, maxMembers: maxMembers) { result in
            switch result {
            case .success(let groupID):
                DispatchQueue.main.async {
                    self.groupID = groupID.map(String.init) 
                    self.groupName = self.group?.group_name ?? "N/A"
                    self.theme = self.group?.theme ?? "N/A"
                }
            case .failure(let error):
                print("Error creating group: \(error.localizedDescription)")
            }
        }
    }
}
