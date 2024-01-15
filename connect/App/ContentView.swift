import SwiftUI

struct ContentView: View {
    @State private var theme: String = ""
    @State private var groupName: String = ""
    @State private var maxMembers: Int = 0
    @State private var isGroupCreate:Bool = false
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView{
            if !appState.shouldNavigateToHelloView{
                VStack{
                    HelloUIView(theme: $theme, groupName: $groupName, maxMembers: $maxMembers)
                }
            } else{
                GroupDetailsUIView(theme: $theme, groupName: $groupName, maxMembers: $maxMembers)
            }
        }
    }

}

//#Preview {
//    ContentView()       
//}
//
