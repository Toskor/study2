//
//  Item.swift
//  study
//
//  Created by Grigory Borisov on 20.12.2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
