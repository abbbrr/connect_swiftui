import SwiftUI

struct ProfileUIView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            VStack{
                Image("smile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 62, height: 62)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                
                Text("Привет, Таня!")
                  .font(
                    Font.custom("SF Pro Text", size: 16)
                      .weight(.semibold)
                  )
                  .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                
            }.padding()
            
            VStack{
                CartForProfileView()
                CartForProfileView()
            }.padding()
            
            Spacer()
            
            Button {
                //
            } label: {
                Text("Выйти")
                  .font(
                    Font.custom("PT Root UI", size: 16)
                      .weight(.medium)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 1, green: 0.23, blue: 0.19))
            }
            .padding(.horizontal, 123)
            .padding(.vertical, 12)
            .frame(width: 300, height: 48, alignment: .center)
            .background(Color(red: 1, green: 0.99, blue: 0.99))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(Color(red: 0.92, green: 0.9, blue: 0.91), lineWidth: 1)
            )

            
        }
        .navigationBarTitle("Профиль", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:backButton)
    }

    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
        }
    }
}

#Preview {
    ProfileUIView()
}
