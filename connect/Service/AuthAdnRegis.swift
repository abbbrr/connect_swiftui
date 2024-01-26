import Foundation
import Alamofire

private let url = "http://127.0.0.1:5000/api/"

class RegisterPost{
    static let shared = RegisterPost()
    private init() {}
    
    func registerUser(username:String, password:String, completion: @escaping(Result<String, Error>) -> Void){
        let registrationData = UserRegistrationModel(username: username, password: password)
        
        AF.request("\(url)register", method: .post, parameters: registrationData, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: UserRegistrationResponse.self) { response in
                switch response.result {
                case .success(let userRegistrationResponse):
                    completion(.success(userRegistrationResponse.message))
                case .failure(let error):
                    print("Error decoding response: \(error.localizedDescription)")
                    if let data = response.data {
                        print("Response data: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")")
                    }
                    completion(.failure(error))
                }
            }
    }
    
    func loginUser(username:String, password:String, complection: @escaping(Result<String, Error>) -> Void){
        let loginData = UserRegistrationModel(username: username, password: password)
        
        AF.request("\(url)login", method: .post, parameters: loginData, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: UserRegistrationResponse.self){ response in
                switch response.result{
                case .success(let userAuthResponse):
                    complection(.success(userAuthResponse.message))
                case .failure(let error):
                    complection(.failure(error))
                }
            }
    }
    
}
