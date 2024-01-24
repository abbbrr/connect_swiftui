import SwiftUI
import Alamofire

struct RegisterUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState:AppState
    
    @State private var username = ""
    @State private var password = ""
    @State private var copyPassword = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isUsernameAvailable: Bool = true
    

    var body: some View {
        // Second VStack
        VStack{
                VStack(alignment:.leading){
                    // Логин
                    VStack(alignment:.leading, spacing: 10){
                        Text("Ваш логин")
                          .font(Font.custom("SF Pro Text", size: 18))
                          .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                          .padding(.leading,10)
                        
                        TextField("Введите ваш логин", text: $username)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .frame(width: 343, height: 44, alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.92, green: 0.9, blue: 0.91), lineWidth: 1)
                            )

                        if !isUsernameAvailable{
                            Text("Логин уже занят")
                                .font(Font.custom("SF Pro Text", size: 15))
                                .foregroundColor(.red)
                                .padding(.leading,15)
                        }
                        
                    } .padding()
                    // Пароль
                    VStack(alignment:.leading, spacing: 15){
                        Text("Пароль")
                            .font(Font.custom("SF Pro Text", size: 18))
                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                            .padding(.leading,10)
                        
                        HStack {
                            ZStack(alignment: .trailing) {
                                if isPasswordVisible{
                                    TextField("Введите пароль", text: $password)
                                        .padding(.horizontal, 24)
                                        .padding(.vertical, 12)
                                        .frame(width: 343, height: 44, alignment: .leading)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color(red: 0.92, green: 0.9, blue: 0.91), lineWidth: 1)
                                        )
                                } else{
                                    SecureField("Введите пароль", text: $password)
                                        .padding(.horizontal, 24)
                                        .padding(.vertical, 12)
                                        .frame(width: 343, height: 44, alignment: .leading)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .inset(by: 0.5)
                                                .stroke(Color(red: 0.92, green: 0.9, blue: 0.91), lineWidth: 1)
                                        )
                                }
                                
                                Button(action: {
                                    isPasswordVisible.toggle()
                                }) {
                                    Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                        .padding(.trailing, 16)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        VStack(spacing: 5){
                            HStack{
                                Image(password.count >= 6 ? "icon_check 1" : "icon_check" )
                                    .foregroundColor(.green)
                                    .bold()
                                Text("минимум 6 знаков")
                                    .font(Font.custom("SF Pro Text", size: 16))
                                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                            }
                            .padding(.trailing,44)
                            
                            HStack{
                                Image(password == copyPassword && password.count >= 6 ? "icon_check 1" : "icon_check" )
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.green)
                                    .bold()
                                
                                Text("пароли должны совпадать")
                                    .font(Font.custom("SF Pro Text", size: 16))
                                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                            }
                            .padding(.leading,20)
                        }
                        .padding(.bottom)
                    }.padding(.leading)
                    // Ворой пароль
                    VStack(alignment:.leading, spacing: 15){
                        Text("Подтверди пароль")
                            .font(Font.custom("SF Pro Text", size: 18))
                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                            .padding(.leading,10)
                        
                        HStack {
                            ZStack(alignment: .trailing) {
                                if isPasswordVisible{
                                    TextField("Введите пароль", text: $copyPassword)
                                        .padding(.horizontal, 24)
                                        .padding(.vertical, 12)
                                        .frame(width: 343, height: 44, alignment: .leading)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color(red: 0.92, green: 0.9, blue: 0.91), lineWidth: 1)
                                        )
                                } else{
                                    SecureField("Введите пароль", text: $copyPassword)
                                        .padding(.horizontal, 24)
                                        .padding(.vertical, 12)
                                        .frame(width: 343, height: 44, alignment: .leading)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .inset(by: 0.5)
                                                .stroke(Color(red: 0.92, green: 0.9, blue: 0.91), lineWidth: 1)
                                        )
                                }
                                
                                Button(action: {
                                    isPasswordVisible.toggle()
                                }) {
                                    Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                        .padding(.trailing, 16)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }.padding(.leading)
                    // Уже есть аккаунт?
                    VStack{
                        HStack{
                            Text("Уже есть аккаунт?")
                              .font(Font.custom("SF Pro Text", size: 16))
                              .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                            
                            NavigationLink(destination: AuthUIView()) {
                                Text("Войти")
                                  .font(
                                    Font.custom("PT Root UI", size: 16)
                                      .weight(.medium)
                                  )
                                  .foregroundColor(Color(red: 0.56, green: 0.16, blue: 0.07))
                            }
                        }
                        
                    }
                    .padding()
                    .padding(.leading)
            }
            Spacer()
            
            createAccountButton
                .foregroundColor(.white)
                .bold()
                .padding(.vertical, 12)
                .frame(width: 343, height: 48, alignment: .center)
                .background(isValidRegistration ? Color(red: 0.56, green: 0.16, blue: 0.07) : Color(.gray))
                .cornerRadius(10)
                .disabled(!isValidRegistration)
            
        }
        .padding()
        .navigationBarTitle("Создание аккаунта", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:backButton)
        // end second
    }
    
    private var createAccountButton: some View {
        Button {
            registerUser()
        } label: {
            Text("Создать аккаунт")
                .buttonStyle(PrimaryButtonStyle())
        }
    }
    
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
        }
    }
    
    private func registerUser() {
        if isValidRegistration {
            Task {
                do {
                    let message = try await registerUserAPI()
                    handleRegistrationSuccess(message: message)
                } catch {
                    handleRegistrationFailure(error: error)
                }
            }
        } else {
            print("Invalid registration parameters")
        }
    }
    
    private var isValidRegistration: Bool {
        password.count >= 6 && password == copyPassword && username.count >= 5
    }
    
    private func registerUserAPI() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            RegisterPost.shared.registerUser(username: username, password: password) { result in
                switch result {
                case .success(let message):
                    appState.username = username
                    appState.password = password
                    appState.isRegisted = true
                    continuation.resume(returning: message)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    private func handleRegistrationSuccess(message: String) {
        isUsernameAvailable = true
        saveUsernameToUserDefaults()
        print("Registration successful. Message: \(message)")
        presentationMode.wrappedValue.dismiss()
    }

    private func handleRegistrationFailure(error: Error) {
        print("Registration failed. Error: \(error.localizedDescription)")
        if let afError = error as? AFError, afError.responseCode == 400 {
            isUsernameAvailable = false
        }
    }
    
    private func saveUsernameToUserDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(username, forKey: "usernameKey")
    }
}


#Preview {
    RegisterUIView()
}
