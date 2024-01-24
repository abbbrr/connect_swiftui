import SwiftUI
import Alamofire

struct AuthUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState:AppState

    @State private var username = ""
    @State private var password = ""
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        VStack{
            VStack(alignment:.leading){
                // Login Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ваш логин")
                        .customFont(style: .title)
                        .foregroundColor(Color(.darkGray))
                        .padding(.leading, 10)
                    
                    TextField("Введите ваш логин", text: $username)
                        .customTextField()
                }
                .padding()

                // Password Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Пароль")
                        .customFont(style: .title)
                        .foregroundColor(Color(.darkGray))
                        .padding(.leading, 10)
                    
                    PasswordField(placeholder: "Введите пароль", text: $password, isPasswordVisible: $isPasswordVisible)
                }
                .padding(.leading)

                // No Account Section
                VStack {
                    HStack {
                        Text("Нету аккаунта?")
                            .customFont(style: .body)
                            .foregroundColor(Color(.darkGray))
                        
                        NavigationLink(destination: RegisterUIView()) {
                            Text("Создать аккаунт")
                                .customFont(style: .body, weight: .medium)
                                .foregroundColor(Color(red: 0.56, green: 0.16, blue: 0.07))
                        }
                    }
                }
                .padding()
                .padding(.leading)
            }
            Spacer()

            // Login Button
            authAccountButton
                .foregroundColor(.white)
                .bold()
                .padding(.vertical, 12)
                .frame(width: 343, height: 48, alignment: .center)
                .background(isValidRegistration ? Color(red: 0.56, green: 0.16, blue: 0.07) : Color(.gray))
                .cornerRadius(10)
                .disabled(!isValidRegistration)
            
        }
        .padding()
        .navigationBarTitle("Авторизация", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: customBackButton)
    }
    
    private var authAccountButton: some View {
        Button {
            authUser()
        } label: {
            Text("Войти")
                .buttonStyle(PrimaryButtonStyle())
        }
    }
    
    private func authUser(){
        RegisterPost.shared.loginUser(username: username, password: password) { result in
            switch result {
            case .success(let message):
                appState.username = username
                appState.password = password
                appState.isRegisted = true
                handleRegistrationSuccess(message: message)
            case .failure(let error):
                handleRegistrationFailure(error: error)
            }
        }
    }
    
    private func handleRegistrationSuccess(message: String) {
        saveUsernameToUserDefaults()
        print("Authriz successful. Message: \(message)")
        presentationMode.wrappedValue.dismiss()
    }

    private func handleRegistrationFailure(error: Error) {
        print("Registration failed. Error: \(error.localizedDescription)")
        if let afError = error as? AFError, afError.responseCode == 400 {
          return
        }
    }
    
    private func saveUsernameToUserDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(username, forKey: "usernameKey")
    }
    
    private var isValidRegistration: Bool {
        password.count >= 6 && !password.isEmpty && username.count >= 5
    }

    private var customBackButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
        }
    }
}

// MARK: - Custom View Modifiers

extension View {
    func customFont(style: FontStyle, weight: Font.Weight = .regular) -> some View {
        self.font(Font.custom("SF Pro Text", size: style.size).weight(weight))
    }

    func customTextField() -> some View {
        self
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .frame(width: 343, height: 44, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .inset(by: 0.5)
                    .stroke(Color(.lightGray), lineWidth: 1)
            )
    }

    func customButton() -> some View {
        self
            .padding(.vertical, 12)
            .frame(width: 343, height: 48, alignment: .center)
            .background(Color(red: 0.56, green: 0.16, blue: 0.07))
            .cornerRadius(10)
    }
}

// MARK: - Custom Password Field

struct PasswordField: View {
    var placeholder: String
    @Binding var text: String
    @Binding var isPasswordVisible: Bool
    
    var body: some View {
        HStack {
            ZStack(alignment: .trailing) {
                if isPasswordVisible {
                    TextField(placeholder, text: $text)
                        .customTextField()
                } else {
                    SecureField(placeholder, text: $text)
                        .customTextField()
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
    }
}

// MARK: - Enum Definitions

enum FontStyle {
    case title
    case body
    case button

    var size: CGFloat {
        switch self {
        case .title:
            return 18
        case .body:
            return 16
        case .button:
            return 16
        }
    }
}

enum FontWeight {
    case regular
    case medium
    case bold
}


#Preview {
    AuthUIView()
}
