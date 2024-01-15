import Foundation

class UserManager: ObservableObject{
    static let shared = UserManager()
    
    @Published var currentUser: UserRegistrationModel?
    
    private init() {}
    
    func loginUser(user: UserRegistrationModel) {
        currentUser = user
    }
}
