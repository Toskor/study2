//
//  ChatView.swift
//  multi
//
//  Created by Yury Korolev on 8/14/23.
//

import SwiftUI



struct ChatView: View {
    @State private var _inputText = ""
#if os(macOS) || os(iOS)
    @Environment(\.openWindow) var openWindow
#endif
    @Environment(\.supportsMultipleWindows) var supportsMultipleWindows
    
    @State private var displayGoals = false
    @State private var displayPolls = false
    @State private var displayHypeTrain = false
    
    @State private var pTw = false;
    @State private var pYt = false;
    @State private var pTr = false;
    @State private var pVl = false;
    
    
    var body: some View {
        ZStack {
            Color.clear
                .frame(width: 300, height: 200)
                .background(Color.white)
                .border(Color.gray)
            
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Menu {
                        Section("Text size") {
                            Button(action: {
                                print("text increase")
                            }) {
                                Label {
                                    Text("Increase")
                                } icon: {
                                    Image (systemName: "plus.circle")
                                }
                            }
                            
                            Button(action: {
                                print("text decrease")
                            }) {
                                Label {
                                    Text("Increase")
                                } icon: {
                                    Image (systemName: "minus.circle")
                                }
                            }
                        }
                        
                        Button("Chat type") {  }
                        Button("Display events") {  }
                        Button("Send to chat") {  }
                        
                        Divider()
                        Toggle(isOn: $displayGoals) {
                            Text("Display goals")
                        }
                        Toggle(isOn: $displayPolls) {
                            Text("Display polls")
                        }
                        Toggle(isOn: $displayHypeTrain) {
                            Text("Display Hype Train")
                        }
                        
                        Divider()
                        Menu("Platforms") {
                            Toggle(isOn: $pTw) {
                                Text("Twitch")
                            }
                            Toggle(isOn: $pYt) {
                                Text("YouTube")
                            }
                            Toggle(isOn: $pTr) {
                                Text("Trovo")
                            }
                            Toggle(isOn: $pVl) {
                                Text("Vk Live")
                            }
                        }
                        
                        
                    } label: {
                        Label {
                            Text("")
                        } icon: {
                            Image (systemName: "chevron.up.circle.fill")
//                                .foregroundColor(Color.AccentColor)
                        }
                    }
                    .menuOrder(.fixed)
                    .menuStyle(.automatic)
                }
                
            }
            
        }
        
        
    }
}

struct TextSizeView: View {
    var body: some View {
        HStack{
            Text("Text size")
//            Spacer()
            
            Button {
                //increase chat text size
            } label: {
                Label {
                    Text("")
                } icon: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.green)
                }
            }
            
            Button {
                //decrease chat text size
            } label: {
                Label {
                    Text("")
                } icon: {
                    Image(systemName: "minus.circle")
                        .foregroundColor(.red)
                }
            }
        }
    }
}


#Preview {
    ChatView()
}

