//
//  TestView3.swift
//  study
//
//  Created by Grigory Borisov on 11.09.2024.
//

import SwiftUI
import Observation



#if os(macOS)
import AppKit

struct ChatMenuView: NSViewRepresentable {
    typealias NSViewType = MenuButton
    
    func makeNSView(context: Context) -> NSViewType {
        MenuButton()
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {}
}

class MenuDelegate: NSObject, NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {
        print("will open")
    }
    func menu(_ menu: NSMenu, update item: NSMenuItem, at index: Int, shouldCancel: Bool) -> Bool {
        print ("menu")
        return true
    }
    func menuNeedsUpdate(_ menu: NSMenu) {
        print("needs update")
//        menu.items[0].title = "New Title"
    }
    
    func numberOfItems(in menu: NSMenu) -> Int {
        return 3
    }
    
}

class TestMenu: NSMenu {
    
    override func cancelTrackingWithoutAnimation() {
        
    }
    
    override func cancelTracking() {
        
    }
    

}

@objc class MenuButton: NSButton {
    let _chatMenuState = ChatMenuState.shared
    let _mainMenu = TestMenu()
    let _menuDelegate = MenuDelegate()
    
    var _increaseFontSizeItem : NSMenuItem! = nil

    init() {
        super.init(frame: .zero)
        _mainMenu.delegate = _menuDelegate
        buildMenu()
    }

    override func mouseDown(with event: NSEvent) {
        if event.type == .leftMouseDown {
            showMenu(with: event)
        } else {
            super.mouseDown(with: event)
        }
    }
    
    @objc private func showMenu(with event: NSEvent) {
        NSMenu.popUpContextMenu(_mainMenu, with: event, for: self)
    }
    
    private func buildMenu() {
        let textSizeMenuItem = NSMenuItem (title: "Text size", action: nil, keyEquivalent: "")
        _mainMenu.addItem(textSizeMenuItem)
        _mainMenu.setSubmenu(buildTextSizeSubmenu(), for: textSizeMenuItem)

        
        let platformsMenuItem = NSMenuItem(title: "Platforms", action: nil, keyEquivalent: "")
        _mainMenu.addItem(platformsMenuItem)
        _mainMenu.setSubmenu(buildPlatformsSubmenu(), for: platformsMenuItem)
        
    }
    
    private func buildTextSizeSubmenu() -> NSMenu {
        _increaseFontSizeItem = NSMenuItem(title: "Increase Font Size", action: #selector(_increaseFontSizeAction), keyEquivalent: "+")
        _increaseFontSizeItem.state = .off
        _increaseFontSizeItem.keyEquivalentModifierMask = .command
        
        let _decreaseFontSizeItem = NSMenuItem(title: "Decrease Font Size", action: #selector(_decreaseFontSizeAction), keyEquivalent: "-")
        _decreaseFontSizeItem.keyEquivalentModifierMask = .command
        
        let textSizeSubmenu = TestMenu(title: "Text size")
        
        textSizeSubmenu.addItem(_increaseFontSizeItem)
        textSizeSubmenu.addItem(_decreaseFontSizeItem)
        
        textSizeSubmenu.selectionMode = .selectAny
        
        return textSizeSubmenu
    }
    
    private func buildPlatformsSubmenu() -> NSMenu {
        let chatMenuState = _chatMenuState
        let platformsSubmenu = NSMenu(title: "Platforms")
//        platformsSubmenu.delegate = _menuDelegate
        
        
        platformsSubmenu.addItem(NSMenuItem(title: "Twitch", action: #selector(toggleTwitch), keyEquivalent: "").withState(chatMenuState.pTw))
        platformsSubmenu.addItem(NSMenuItem(title: "YouTube", action: #selector(toggleYouTube), keyEquivalent: "").withState(chatMenuState.pYt))
        platformsSubmenu.addItem(NSMenuItem(title: "Trovo", action: #selector(toggleTrovo), keyEquivalent: "").withState(chatMenuState.pTr))
        platformsSubmenu.addItem(NSMenuItem(title: "Vk Live", action: #selector(toggleVkLive), keyEquivalent: "").withState(chatMenuState.pVl))
        
        
        
        
        return platformsSubmenu
    }
    
    var state2 = NSControl.StateValue.off
    
    @objc private func _increaseFontSizeAction() {
        print("Increase Font Size selected")
        _increaseFontSizeItem.state = state2
        if state2 == .on {
            state2 = .off
        } else {
            state2 = .on
        }
    }
    
    @objc private func _decreaseFontSizeAction() {
        print("Decrease Font Size selected")
        let testMenuItem = NSMenuItem(title: "New test Item", action: #selector(_decreaseFontSizeAction), keyEquivalent: "")
        _mainMenu.addItem(testMenuItem)
    }
    
    @objc private func _togglePlatform() {}
    
    @objc func toggleTwitch() {
        _chatMenuState.pTw.toggle()
    }
    
    @objc func toggleYouTube() {
        _chatMenuState.pYt.toggle()
    }
    
    @objc func toggleTrovo() {
        _chatMenuState.pTr.toggle()
    }
    
    @objc func toggleVkLive() {
        _chatMenuState.pVl.toggle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NSMenuItem {
    func withState(_ state: Bool) -> NSMenuItem {
        self.state = state ? .on : .off
        return self
    }
}

#endif

struct ViewControllerPreview_Previews: PreviewProvider {
    static var previews: some View {
        ChatMenuView()
    }
}

//move from this file
@Observable public class ChatMenuState {
    static let shared = ChatMenuState()
    private init() {}
    
    public var displayGoals = false
    public var displayPolls = false
    public var displayHypeTrain = false

    public var pTw = true;
    public var pYt = false;
    public var pTr = false;
    public var pVl = false;
    
    public var tAllEvents = false;
    public var tChatMsg = false;
    public var tDonates = false;
    public var tPaidEvents = false;
    
    public var eChatMsgs = false;
    public var eDonations = false;
    public var ePaidMsgs = false;
    public var ePaidEvent = false;
    public var ePrivMsgs = false;
    public var eTwRewards = false;
    public var eFollows = false;
    public var eNewChatter = false;
    public var eRaids = false;
    public var eSubs = false;
}
