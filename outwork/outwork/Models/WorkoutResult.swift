//
//  WorkoutResult.swift
//  outwork
//
//  Created by Chris Feher on 2020-11-09.
//

import Foundation

// MARK: - WorkoutResult

struct WorkoutResult: Identifiable, Codable, Hashable {
    var id = String()
    var workoutResultTime = String()
    var workoutResultReps = String()
    var workoutRating: Bool = true
    var workoutResultNotes: String = String()
}

// MARK: - Helper Methods

extension WorkoutResult {

    // TODO: - Delete this function when proper types are added to WorkoutResult
    var isTimeBased: Bool {
        !workoutResultTime.isEmpty
    }

    // TODO: - Delete this function when proper types are added to WorkoutResult
    var workoutLengthSeconds: TimeInterval {

        var multiplier: TimeInterval = 1
        var totalSeconds: TimeInterval = 0
        for component in workoutResultTime.split(separator: ":").reversed() {
            // This error is fatal. We shouldnt really be continuing the calculation
            // here but this function will be deleted when proper types are added to
            // Workout.
            guard let timeInterval = TimeInterval(component) else { continue }
            totalSeconds += timeInterval * multiplier

            switch multiplier {
                case 1:
                    multiplier = 60
                case 60:
                    multiplier = 60 * 24
                default:
                    break
            }
        }

        return totalSeconds
    }
}
