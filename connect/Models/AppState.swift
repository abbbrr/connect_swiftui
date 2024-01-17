import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var shouldNavigateToHelloView = false
    @Published var groupId:Int = 0
    @Published var groupName: String = ""
    @Published var theme: String = ""
    @Published var maxMembers: Int = 0
    @Published var members:[String?: String] = [:]
}
