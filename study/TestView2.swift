import SwiftUI

struct ContentView2: View {
    @State private var showPopover = false
    @State private var option1Selected = false
    @State private var option2Selected = false
    
    @State private var selectedSorting = MainChatMenu.textSize

    var body: some View {
        Picker("Sort", selection: $selectedSorting) {
            ForEach(MainChatMenu.allCases) {
                Text($0.title)
                    .tag($0)
            }
        }
    }
}

enum MainChatMenu: String, CaseIterable, Identifiable {
    case textSize
    case chatType
    case displayEvents
    case sendToChat
    case displayGoals
    case displayPolls
    case displayHypeTrain
    case platforms
    
    var id: Self { return self }
    
    var title: String {
        switch self {
        case .textSize:
            return "Text size"
        case .chatType:
            return "Chat type"
        case .displayEvents:
            return "Display event"
        case .sendToChat:
            return "Send to chat"
        case .displayGoals:
            return "Display goals"
        case .displayPolls:
            return "Display polls"
        case .displayHypeTrain:
            return "Display HypeTrain"
        case .platforms:
            return "Platforms"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
