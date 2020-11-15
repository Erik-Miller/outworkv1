//
//  Array+WorkoutResult.swift
//  outwork
//
//  Created by Chris Feher on 2020-11-09.
//

import Foundation

extension Array where Element == WorkoutResult {

    func totalReps(workoutReps: String) -> Int {
        var totalReps: Int = Int()

        for workoutResult in self
        {
            totalReps += Int(workoutResult.workoutResultReps) ?? 0
        }
        return totalReps
    }
    
    
}
