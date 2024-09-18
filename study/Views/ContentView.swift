import SwiftUI


struct ContentView: View {
    
    var body: some View {
        SimpleWebView(url: URL(string: "https://www.google.com")!)
            .frame(minWidth: 300, minHeight: 300)
    }
}

import SwiftUI
import Network
import Dispatch


struct ViewWithToolbar: View {
    @State private var _inputText = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Some text")
            }
            .toolbar {
                ToolbarItemGroup(placement: ToolbarPlacement()) {
                    Button(action:{
                        print("test button 1")
                    }) {Label (
                        title: {  },
                        icon: { Image(systemName: "pencil.line") }
                        
                    )}
                    ChatMenuView()
                }
            }
        }
            .navigationTitle("Chat")
//            .toolbarTitleDisplayMode(.inline)
        
    }
}


fileprivate func ToolbarPlacement() -> ToolbarItemPlacement {
#if os(macOS)
    return .automatic
#else
    return .navigationBarTrailing
#endif
}



