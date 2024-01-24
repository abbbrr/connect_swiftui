import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @State private var isActiveLink = false
    
    var body: some View {
        NavigationView{
            VStack{
                if !appState.shouldNavigateToHelloView{
                    HelloUIView()
                } else if isActiveLink{
                    GroupDetailsUIView()
                        .onAppear(){
                            print(appState.maxMembers)
                            print(appState.username)
                            print(appState.groupName)
                            print(appState.groupId)
                            print(appState.theme)
                        }
                }else{
                    ProgressView("Создается группа...")
                }
            }
            .onAppear{
                if appState.shouldNavigateToHelloView{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        isActiveLink = true
                    }
                }
            }
        }
    }

}
