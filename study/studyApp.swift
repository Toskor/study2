//
//  studyApp.swift
//  study
//
//  Created by Grigory Borisov on 20.12.2023.
//

import SwiftUI
#if os(iOS)
import UIKit
#endif


@main
struct studyApp: App {
    var body: some Scene {
        WindowGroup {
//            ChatMenuView()
            ViewWithToolbar()
                
        }
        
    }
}
