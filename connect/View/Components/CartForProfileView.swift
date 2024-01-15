import SwiftUI

struct CartForProfileView: View {
    var body: some View {
        HStack{
            Image(systemName: "person.3")
                .frame(width: 32, height: 32, alignment: .center)

            Text("Мои группы")
                .font(
                    Font.custom("PT Root UI", size: 16)
                    .weight(.medium)
                )
                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
        }
        .padding(.leading)
        .padding(.horizontal, 0)
        .padding(.top, 8)
        .padding(.bottom, 5)
        .frame(width: 300, height: 48, alignment: .leading)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
            .inset(by: 0.5)
            .stroke(Color(red: 0.92, green: 0.9, blue: 0.91), lineWidth: 1)
        )
    }
}

#Preview {
    CartForProfileView()
}
