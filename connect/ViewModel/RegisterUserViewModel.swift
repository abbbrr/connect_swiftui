//import Foundation
//
//RegisterPost.shared.registerUser(username: String, password: String) { result in
//    switch result {
//        case .success(let message):
//            let userDefaults = UserDefaults.standard
//            userDefaults.set(username, forKey: "usernameKey")
//            print("Registration successful. Message: \(message)")
//        case .failure(let error):
//            print("Registration failed. Error: \(error.localizedDescription)")
//        if let afError = error as? AFError, afError.responseCode == 400{
//            
//        }
//    }
//}
