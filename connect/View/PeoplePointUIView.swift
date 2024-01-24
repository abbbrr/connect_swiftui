
import SwiftUI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

struct PeoplePointUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState:AppState
    @ObservedObject private var viewModel = GroupViewModel()
    var groupNames: [String]
    
    @State private var selectedPeople: Int?
    let peopleCounts: [Int] = [3,4,5,6,7,8]
        
    var body: some View {
        VStack {
            Spacer()
            ForEach(peopleCounts.chunked(into: 3), id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { people in
                        Button(action: {
                            selectedPeople = people
                            appState.maxMembers = selectedPeople ?? 0
                        },
                        label: {
                            Text("\(people)")
                                .font(
                                    Font.custom("Urbanist", size: 22)
                                        .weight(.bold)
                                )
                                .foregroundColor(Color(red: 0.12, green: 0.14, blue: 0.17))
                        })
                        .foregroundColor(.clear)
                        .frame(width: 70, height: 60)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.98))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .inset(by: 0.5)
                                .stroke(selectedPeople == people  ? Color(red: 0.21, green: 0.76, blue: 0.76) : Color(red: 0.91, green: 0.93, blue: 0.96), lineWidth: 1)
                        )
                    }
                }
                .padding(.bottom, 8)
            }
            Spacer()
            createGroupButton
        }
        .navigationBarTitle("Количества участников", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton, trailing: profileButton)
    }
    
    private var createGroupButton: some View{
        Button {
            createGroup()
            appState.shouldNavigateToHelloView = true
        } label: {
            Text("Создать группу")
                .foregroundColor(Color(.white))
                .font(.title2)
                .bold()
        }
        .frame(width: 300, height: 50)
        .foregroundColor(.clear)
        .background(createGroupButtonColor)
        .cornerRadius(16)
        .padding()
        .padding(.bottom)
        .disabled((selectedPeople == nil))
    }
    
    private func createGroup() {
        if let firstGroupName = groupNames.first{
            appState.groupName = firstGroupName
        }
        viewModel.createGroup(groupName: appState.groupName, theme: appState.theme, maxMembers: appState.maxMembers, username: appState.username) { result in
            switch result {
            case .success(let groupID):
                appState.groupId = groupID
                print("Received group ID: \(groupID)")
            case .failure(let error):
                print("Failed to create group: \(error.localizedDescription)")
            }
        }
    }

    
    private var createGroupButtonColor: Color {
        return (selectedPeople != nil) ? Color(red: 0.89, green: 0.38, blue: 0.41) : Color(.gray)
     }
    
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
        }
    }
    
    private var profileButton: some View{
        HStack{
            NavigationLink(destination: ProfileUIView()) {
                Image(systemName: "person.circle")
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    PeoplePointUIView(groupNames: ["Banda"])
}
