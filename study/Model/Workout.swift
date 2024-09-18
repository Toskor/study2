//
//  Workout.swift
//  study
//
//  Created by Grigory Borisov on 22.12.2023.
//

import Foundation
import Observation

@Observable
class Workout: Identifiable {
    var name: String = "Default Workout"
    var duration: Double = 30.0
    var intensity: String = "Moderate"
    var inProgress: Bool = false
    
    var status: String {
        if inProgress {
            return "workout in progress. Duration \(duration) minutes"
        } else {
            return "workout not started"
        }
    }
}
