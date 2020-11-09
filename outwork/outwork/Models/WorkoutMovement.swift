//
//  WorkoutMovement.swift
//  outwork
//
//  Created by Chris Feher on 2020-11-09.
//

import Foundation

struct WorkoutMovement: Identifiable {
    var id = String()
    var movementName = String()
    var movementWeight = String()
    var movementReps = String()
    var movementCalories = String()
    var movementDistance = String()
}

extension WorkoutMovement: Codable {
    
}

extension WorkoutMovement: Hashable {
    
}
