//
//  TestView3.swift
//  study
//
//  Created by Grigory Borisov on 11.09.2024.
//

import SwiftUI
import Observation

#if os(iOS)
import UIKit
class MenuViewController: UIViewController {
    var _chatMenuState = ChatMenuState.shared;
    var _menu: UIMenu! = nil
    var _menuButton: UIButton! = nil
    var _textSizeMenu = UIMenu(title: "Text Size", options: [.displayAsPalette, .displayInline])
    var _displayedEventsMenu: UIMenu = UIMenu(title: "Display events")
    var _chatTypeMenu: UIMenu = UIMenu(title: "Chat type")
    var _platformsMenu = UIMenu(title: "Platforms")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuButton = UIButton(type: .system)
        menuButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuButton)
        
        _menuButton = menuButton
        
        NSLayoutConstraint.activate([
            menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        _buildMenu()
    }
    
    @objc func _increaseFontSizeAction() {
        print("Increase Font Size selected")
    }
    @objc func _decreaseFontSizeAction() {
        print("Decrease Font Size selected")
    }
    @objc func sendChatMsgAction() {
        print("Send chat message selected")
    }
    
    func _rebuildMenu(menu: UIMenu) -> UIMenu {
        var menu = _buildPlatformsMenu(menu)
        menu = _buildTextSizeMenu(menu)
        menu = _buildDisplayedEventsMenu(menu)
        menu = _buildChatTypeMenu(menu)
        return menu
    }
    
    func rebuildVisibleMenus() {
        _menuButton.contextMenuInteraction?.updateVisibleMenu({ menu in
            self._rebuildMenu(menu: menu)
        })
    }
    
    func _buildTextSizeMenu(_ menu: UIMenu) -> UIMenu {
        guard menu == _textSizeMenu
        else {
            return menu
        }
        
        let _increaseFontSizeAction = UIKeyCommand (title: "",
                                             image: UIImage(systemName: "plus.circle"),
                                             action: #selector(_increaseFontSizeAction),
                                             input: "+",
                                             modifierFlags: .command)
        _increaseFontSizeAction.attributes = .keepsMenuPresented

        
        let _decreaseFontSizeAction = UIKeyCommand (title: "",
                                             image: UIImage(systemName: "minus.circle"),
                                             action: #selector(_decreaseFontSizeAction),
                                             input: "-",
                                             modifierFlags: .command)
        _decreaseFontSizeAction.attributes = .keepsMenuPresented
        
        let actions = [_increaseFontSizeAction, _decreaseFontSizeAction]
        _textSizeMenu = _textSizeMenu.replacingChildren(actions)
        return _textSizeMenu
    }
    
    func _buildChatTypeMenu(_ menu: UIMenu) -> UIMenu {
        guard menu == _chatTypeMenu
        else {
            return menu
        }
        
        let chatMenuState = _chatMenuState
        let refreshMenu = self.rebuildVisibleMenus

        let actions = [
            UIAction(title: "All events", state: chatMenuState.tAllEvents ? .on : .off) { action in
                 chatMenuState.tAllEvents = true
                 chatMenuState.tChatMsg = false
                 chatMenuState.tDonates = false
                 chatMenuState.tPaidEvents = false

                 chatMenuState.eChatMsgs = true
                 chatMenuState.eDonations = true
                 chatMenuState.ePaidMsgs = true
                 chatMenuState.ePaidEvent = true
                 chatMenuState.ePrivMsgs = true
                 chatMenuState.eTwRewards = true
                 chatMenuState.eFollows = true
                 chatMenuState.eNewChatter = true
                 chatMenuState.eRaids = true
                 chatMenuState.eSubs = true

                refreshMenu()
                _ = self._rebuildMenu(menu: self._displayedEventsMenu)
            }.withAttributes([.keepsMenuPresented]),
            
            UIAction(title: "Chat message", state: chatMenuState.tChatMsg ? .on : .off) { action in
                chatMenuState.tAllEvents = false
                chatMenuState.tChatMsg = true
                chatMenuState.tDonates = false
                chatMenuState.tPaidEvents = false

                chatMenuState.eChatMsgs = true
                chatMenuState.eDonations = false
                chatMenuState.ePaidMsgs = true
                chatMenuState.ePaidEvent = true
                chatMenuState.ePrivMsgs = false
                chatMenuState.eTwRewards = true
                chatMenuState.eFollows = false
                chatMenuState.eNewChatter = true
                chatMenuState.eRaids = true
                chatMenuState.eSubs = false

               refreshMenu()
            }.withAttributes([.keepsMenuPresented]),
            
            UIAction(title: "Donations", state: chatMenuState.tDonates ? .on : .off) { action in
                chatMenuState.tAllEvents = false
                chatMenuState.tChatMsg = false
                chatMenuState.tDonates = true
                chatMenuState.tPaidEvents = false

                chatMenuState.eChatMsgs = false
                chatMenuState.eDonations = true
                chatMenuState.ePaidMsgs = false
                chatMenuState.ePaidEvent = false
                chatMenuState.ePrivMsgs = false
                chatMenuState.eTwRewards = false
                chatMenuState.eFollows = false
                chatMenuState.eNewChatter = false
                chatMenuState.eRaids = false
                chatMenuState.eSubs = false

               refreshMenu()
            }.withAttributes([.keepsMenuPresented]),
            
            UIAction(title: "Paid events", state: chatMenuState.tPaidEvents ? .on : .off) { action in
                chatMenuState.tAllEvents = false
                chatMenuState.tChatMsg = false
                chatMenuState.tDonates = false
                chatMenuState.tPaidEvents = true

                chatMenuState.eChatMsgs = false
                chatMenuState.eDonations = true
                chatMenuState.ePaidMsgs = true
                chatMenuState.ePaidEvent = true
                chatMenuState.ePrivMsgs = false
                chatMenuState.eTwRewards = true
                chatMenuState.eFollows = false
                chatMenuState.eNewChatter = false
                chatMenuState.eRaids = false
                chatMenuState.eSubs = true

                refreshMenu()
            }.withAttributes([.keepsMenuPresented]),
        ]
        
        _chatTypeMenu = _chatTypeMenu.replacingChildren(actions)
        return _chatTypeMenu
    }
    
    func _buildDisplayedEventsMenu(_ menu: UIMenu) -> UIMenu {
        guard menu == _displayedEventsMenu
        else {
            return menu
        }
        
        let chatMenuState = _chatMenuState
        let refreshMenu = self.rebuildVisibleMenus
        
        
        let actions = UIDeferredMenuElement.uncached { callback in
            callback([
                UIAction(title: "Chat messages", state: chatMenuState.eChatMsgs ? .on : .off) { action in
                    chatMenuState.eChatMsgs.toggle()
                    refreshMenu()
                }
                .withAttributes([.keepsMenuPresented]),
                
                UIAction(title: "Donations", state: chatMenuState.eDonations ? .on : .off) { action in
                    chatMenuState.eDonations.toggle()
                    refreshMenu()
                }
                .withAttributes([.keepsMenuPresented]),
                    
                UIAction(title: "Paid messages", state: chatMenuState.ePaidMsgs ? .on : .off) { action in
                    chatMenuState.ePaidMsgs.toggle()
                    refreshMenu()
                }
                .withAttributes([.keepsMenuPresented]),
                    
                UIAction(title: "Paid events", state: chatMenuState.ePaidEvent ? .on : .off) { action in
                    chatMenuState.ePaidEvent.toggle()
                    refreshMenu()
                }
                .withAttributes([.keepsMenuPresented]),
                    
                UIAction(title: "Private messages", state: chatMenuState.ePrivMsgs ? .on : .off) { action in
                    chatMenuState.ePrivMsgs.toggle()
                    refreshMenu()
                }
                .withAttributes([.keepsMenuPresented]),
                    
                UIAction(title: "Twitch rewards", state: chatMenuState.eTwRewards ? .on : .off) { action in
                    chatMenuState.eTwRewards.toggle()
                    refreshMenu()
                }
                .withAttributes([.keepsMenuPresented]),
                    
                UIAction(title: "Follow", state: chatMenuState.eFollows ? .on : .off) { action in
                    chatMenuState.eFollows.toggle()
                    refreshMenu()
                }
                .withAttributes([.keepsMenuPresented]),
                    
                UIAction(title: "New chatter", state: chatMenuState.eNewChatter ? .on : .off) { action in
                    chatMenuState.eNewChatter.toggle()
                    refreshMenu()
                }
                .withAttributes([.keepsMenuPresented]),
                    
                UIAction(title: "Raids", state: chatMenuState.eRaids ? .on : .off) { action in
                    chatMenuState.eRaids.toggle()
                    refreshMenu()
                }
                .withAttributes([.keepsMenuPresented]),
                    
                UIAction(title: "Subscriptions", state: chatMenuState.eSubs ? .on : .off) { action in
                    chatMenuState.eSubs.toggle()
                    refreshMenu()
                }
                .withAttributes([.keepsMenuPresented])
            ])
        }
        
        _displayedEventsMenu = _displayedEventsMenu.replacingChildren([actions])
        return _displayedEventsMenu
    }
    
    func _buildPlatformsMenu(_ menu: UIMenu) -> UIMenu {
        guard menu == _platformsMenu
        else {
            return menu
        }
        
        let chatMenuState = _chatMenuState
        let refreshMenu = self.rebuildVisibleMenus
        
        let actions = [
            UIAction(title: "Twitch", state: chatMenuState.pTw ? .on : .off) { action in
                chatMenuState.pTw.toggle()
                refreshMenu()
            }.withAttributes(.keepsMenuPresented),
            UIAction(title: "YouTube", state: chatMenuState.pYt ? .on : .off) { action in
                chatMenuState.pYt.toggle()
                refreshMenu()
            }.withAttributes(.keepsMenuPresented),
            UIAction(title: "Trovo", state: chatMenuState.pTr ? .on : .off) { action in
                chatMenuState.pTr.toggle()
                refreshMenu()
            }.withAttributes(.keepsMenuPresented),
            UIAction(title: "Vk Live", state: chatMenuState.pVl ? .on : .off) { action in
                chatMenuState.pVl.toggle()
                refreshMenu()
            }.withAttributes(.keepsMenuPresented)
        ]
        
        _platformsMenu = _platformsMenu.replacingChildren(actions)
        return _platformsMenu
    }
    
    func _buildMenu() {
        let chatMenuState = _chatMenuState
        
        _ = _buildTextSizeMenu(_textSizeMenu)
        _ = _buildPlatformsMenu(_platformsMenu)
        _ = _buildDisplayedEventsMenu(_displayedEventsMenu)
        _ = _buildChatTypeMenu(_chatTypeMenu)
        
        let displayGoalsToggle = UIAction(title: "Display goals", state: chatMenuState.displayGoals ? .on : .off) { action in
            print("Display goals toggled")
            chatMenuState.displayGoals.toggle()
        }
        displayGoalsToggle.attributes = .keepsMenuPresented
        
        let displayPollsToggle = UIAction(title: "Display polls", state: chatMenuState.displayPolls ? .on : .off) { action in
            print("Display polls toggled")
            chatMenuState.displayPolls.toggle()
        }
        displayPollsToggle.attributes = .keepsMenuPresented
        
        let displayHypeTrainToggle = UIAction(title: "Display Hype Train", state: chatMenuState.displayHypeTrain ? .on : .off) { action in
            print("Display Hype Train toggled")
            chatMenuState.displayHypeTrain.toggle()
        }
        displayHypeTrainToggle.attributes = .keepsMenuPresented
        
        let sendChatMsgAction = UIKeyCommand (title: "Send chat message",
                                             action: #selector(sendChatMsgAction),
                                             input: "m",
                                             modifierFlags: .command)
        sendChatMsgAction.attributes = .keepsMenuPresented
        
        let b = UIDeferredMenuElement.uncached { callback in
            callback([
                self._textSizeMenu,
                self._chatTypeMenu,
                self._displayedEventsMenu,
                displayGoalsToggle,
                displayPollsToggle,
                displayHypeTrainToggle,
                self._platformsMenu
            ])
        }
        
        let _mainMenu = UIMenu(title: "", options: .displayInline, children: [b])
        
        
//        let menuButton = view.subviews.first { $0 is UIButton } as? UIButton
//        menuButton?.menu = _mainMenu
//        menuButton?.showsMenuAsPrimaryAction = true
        _menuButton!.menu = _mainMenu
        _menuButton!.showsMenuAsPrimaryAction = true
    }
}
extension UIAction {
    func withAttributes(_ attributes: UIMenuElement.Attributes) -> UIAction {
        let action = self
        action.attributes = attributes
        return action
    }
}

struct ChatMenuView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MenuViewController {
        return MenuViewController()
    }
    
    func updateUIViewController(_ uiViewController: MenuViewController, context: Context) {
        
    }
}
#endif

#if os(macOS)
import AppKit

class MenuViewController: NSViewController {
    var chatMenuState = ChatMenuState.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuButton = NSButton(title: "Show Menu", target: self, action: #selector(showMenu))
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuButton)
        
        NSLayoutConstraint.activate([
            menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        self.showMenu()
    }
    
    @objc func _increaseFontSizeAction() {
        print("Increase Font Size selected")
    }
    
    @objc func _decreaseFontSizeAction() {
        print("Decrease Font Size selected")
    }
    
    @objc func sendChatMsgAction() {
        print("Send chat message selected")
    }
    
    @objc func showMenu() {
        let _increaseFontSizeAction = NSMenuItem(title: "Increase Font Size", action: #selector(_increaseFontSizeAction), keyEquivalent: "+")
        _increaseFontSizeAction.keyEquivalentModifierMask = .command
        
        let _decreaseFontSizeAction = NSMenuItem(title: "Decrease Font Size", action: #selector(_decreaseFontSizeAction), keyEquivalent: "-")
        _decreaseFontSizeAction.keyEquivalentModifierMask = .command
        
        let textSizeMenu = NSMenu(title: "Text size")
        textSizeMenu.addItem(_increaseFontSizeAction)
        textSizeMenu.addItem(_decreaseFontSizeAction)
        
        let allEventsToggle = NSMenuItem(title: "All events", action: #selector(toggleAllEvents), keyEquivalent: "")
        allEventsToggle.state = .off
        
        let chatMsgToggle = NSMenuItem(title: "Chat message", action: #selector(toggleChatMsg), keyEquivalent: "")
        chatMsgToggle.state = .off
        
        let donatesToggle = NSMenuItem(title: "Donates", action: #selector(toggleDonates), keyEquivalent: "")
        donatesToggle.state = .off
        
        let paidEventsToggle = NSMenuItem(title: "Paid events", action: #selector(togglePaidEvents), keyEquivalent: "")
        paidEventsToggle.state = .off
        
        let chatTypeMenu = NSMenu(title: "Chat type")
        chatTypeMenu.addItem(allEventsToggle)
        chatTypeMenu.addItem(chatMsgToggle)
        chatTypeMenu.addItem(donatesToggle)
        chatTypeMenu.addItem(paidEventsToggle)
        
        let displayGoalsToggle = NSMenuItem(title: "Display goals", action: #selector(toggleDisplayGoals), keyEquivalent: "")
        displayGoalsToggle.state = chatMenuState.displayGoals ? .on : .off
        
        let displayPollsToggle = NSMenuItem(title: "Display polls", action: #selector(toggleDisplayPolls), keyEquivalent: "")
        displayPollsToggle.state = chatMenuState.displayPolls ? .on : .off
        
        let displayHypeTrainToggle = NSMenuItem(title: "Display Hype Train", action: #selector(toggleDisplayHypeTrain), keyEquivalent: "")
        displayHypeTrainToggle.state = chatMenuState.displayHypeTrain ? .on : .off
        
        let displayedEventsMenu = NSMenu(title: "Display events")
        displayedEventsMenu.addItem(NSMenuItem(title: "Chat messages", action: #selector(toggleChatMessages), keyEquivalent: "").withState(chatMenuState.eChatMsgs))
        displayedEventsMenu.addItem(NSMenuItem(title: "Donations", action: #selector(toggleDonations), keyEquivalent: "").withState(chatMenuState.eDonations))
        displayedEventsMenu.addItem(NSMenuItem(title: "Paid messages", action: #selector(togglePaidMessages), keyEquivalent: "").withState(chatMenuState.ePaidMsgs))
        displayedEventsMenu.addItem(NSMenuItem(title: "Paid events", action: #selector(togglePaidEvents), keyEquivalent: "").withState(chatMenuState.ePaidEvent))
        displayedEventsMenu.addItem(NSMenuItem(title: "Private messages", action: #selector(togglePrivateMessages), keyEquivalent: "").withState(chatMenuState.ePrivMsgs))
        displayedEventsMenu.addItem(NSMenuItem(title: "Twitch rewards", action: #selector(toggleTwitchRewards), keyEquivalent: "").withState(chatMenuState.eTwRewards))
        displayedEventsMenu.addItem(NSMenuItem(title: "Follow", action: #selector(toggleFollow), keyEquivalent: "").withState(chatMenuState.eFollows))
        displayedEventsMenu.addItem(NSMenuItem(title: "New chatter", action: #selector(toggleNewChatter), keyEquivalent: "").withState(chatMenuState.eNewChatter))
        displayedEventsMenu.addItem(NSMenuItem(title: "Raids", action: #selector(toggleRaids), keyEquivalent: "").withState(chatMenuState.eRaids))
        displayedEventsMenu.addItem(NSMenuItem(title: "Subscriptions", action: #selector(toggleSubscriptions), keyEquivalent: "").withState(chatMenuState.eSubs))
        
        let platformsMenu = NSMenu(title: "Platforms")
        platformsMenu.addItem(NSMenuItem(title: "Twitch", action: #selector(toggleTwitch), keyEquivalent: "").withState(chatMenuState.pTw))
        platformsMenu.addItem(NSMenuItem(title: "YouTube", action: #selector(toggleYouTube), keyEquivalent: "").withState(chatMenuState.pYt))
        platformsMenu.addItem(NSMenuItem(title: "Trovo", action: #selector(toggleTrovo), keyEquivalent: "").withState(chatMenuState.pTr))
        platformsMenu.addItem(NSMenuItem(title: "Vk Live", action: #selector(toggleVkLive), keyEquivalent: "").withState(chatMenuState.pVl))
        
        let sendChatMsgAction = NSMenuItem(title: "Send chat message", action: #selector(sendChatMsgAction), keyEquivalent: "m")
        sendChatMsgAction.keyEquivalentModifierMask = .command
        
        // main part
        let _mainMenu = NSMenu(title: "")
        
        let textSizeMenuItem = NSMenuItem(title: "Text size", action: nil, keyEquivalent: "")
        _mainMenu.addItem(textSizeMenuItem)
        _mainMenu.setSubmenu(textSizeMenu, for: textSizeMenuItem)
        
        let chatTypeMenuItem = NSMenuItem(title: "Chat type", action: nil, keyEquivalent: "")
        _mainMenu.addItem(chatTypeMenuItem)
        _mainMenu.setSubmenu(chatTypeMenu, for: chatTypeMenuItem)
        
        let displayEventsMenuItem = NSMenuItem(title: "Display events", action: nil, keyEquivalent: "")
        _mainMenu.addItem(displayEventsMenuItem)
        _mainMenu.setSubmenu(displayedEventsMenu, for: displayEventsMenuItem)
        
        _mainMenu.addItem(sendChatMsgAction)
        _mainMenu.addItem(displayGoalsToggle)
        _mainMenu.addItem(displayPollsToggle)
        _mainMenu.addItem(displayHypeTrainToggle)

        let platformsMenuItem = NSMenuItem(title: "Platforms", action: nil, keyEquivalent: "")
        _mainMenu.addItem(platformsMenuItem)
        _mainMenu.setSubmenu(platformsMenu, for: platformsMenuItem)
        
        let menuButton = view.subviews.first { $0 is NSButton } as? NSButton
        menuButton?.menu = _mainMenu
    }
    
    @objc func toggleAllEvents() {
        print("All events toggled")
    }
    
    @objc func toggleChatMsg() {
        print("Chat message toggled")
    }
    
    @objc func toggleDonates() {
        print("Donates toggled")
    }
    
    @objc func togglePaidEvents() {
        print("Paid events toggled")
    }
    
    @objc func toggleDisplayGoals() {
        print("Display goals toggled")
        chatMenuState.displayGoals.toggle()
        self.showMenu()
    }
    
    @objc func toggleDisplayPolls() {
        print("Display polls toggled")
        chatMenuState.displayPolls.toggle()
        self.showMenu()
    }
    
    @objc func toggleDisplayHypeTrain() {
        print("Display Hype Train toggled")
        chatMenuState.displayHypeTrain.toggle()
    }
    
    @objc func toggleChatMessages() {
        print("Chat messages toggled")
        chatMenuState.eChatMsgs.toggle()
        self.showMenu()
    }
    
    @objc func toggleDonations() {
        print("Donations toggled")
        chatMenuState.eDonations.toggle()
        self.showMenu()
    }
    
    @objc func togglePaidMessages() {
        print("Paid messages toggled")
        chatMenuState.ePaidMsgs.toggle()
        self.showMenu()
    }
    
    @objc func togglePrivateMessages() {
        print("Private messages toggled")
        chatMenuState.ePrivMsgs.toggle()
        self.showMenu()
    }
    
    @objc func toggleTwitchRewards() {
        print("Twitch rewards toggled")
        chatMenuState.eTwRewards.toggle()
        self.showMenu()
    }
    
    @objc func toggleFollow() {
        print("Follow toggled")
        chatMenuState.eFollows.toggle()
        self.showMenu()
    }
    
    @objc func toggleNewChatter() {
        print("New chatter toggled")
        chatMenuState.eNewChatter.toggle()
        self.showMenu()
    }
    
    @objc func toggleRaids() {
        print("Raids toggled")
        chatMenuState.eRaids.toggle()
        self.showMenu()
    }
    
    @objc func toggleSubscriptions() {
        print("Subscriptions toggled")
        chatMenuState.eSubs.toggle()
        self.showMenu()
    }
    
    @objc func toggleTwitch() {
        print("Twitch toggled")
        chatMenuState.pTw.toggle()
        self.showMenu()
    }
    
    @objc func toggleYouTube() {
        print("YouTube toggled")
        chatMenuState.pYt.toggle()
        self.showMenu()
    }
    
    @objc func toggleTrovo() {
        print("Trovo toggled")
        chatMenuState.pTr.toggle()
        self.showMenu()
    }
    
    @objc func toggleVkLive() {
        print("Vk Live toggled")
        chatMenuState.pVl.toggle()
        self.showMenu()
    }
}



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
