//
//  WorkoutModel.swift
//  outwork
//
//  Created by Erik Miller on 10/25/20.
//

import Foundation
import Combine

struct Workout {
    // The title of the workout
    var title: String
    // The description of the workout
    var description: String
    // The date and time the workout was completed.
    // This will be used to uniquely identify workouts.
    var date: Date
    var workoutTime: String
    var workoutRounds: String
    
    var workoutMovements = [WorkoutMovement]()
    
    var workoutResults = [WorkoutResult]()

    init(
        workoutTitle: String,
        workoutDescription: String,
        completionDate: Date = Date(),
        workoutTime: String,
        workoutRounds: String,
        workoutMovements: [WorkoutMovement],
        workoutResults: [WorkoutResult] = []
       
    ) {
        self.title = workoutTitle
        self.description = workoutDescription
        self.date = completionDate
        self.workoutTime = workoutTime
        self.workoutRounds = workoutRounds
        self.workoutMovements = workoutMovements
        self.workoutResults = workoutResults
        
    }
}

// Time based calculations

extension Workout {

    // TODO: - Delete this function when proper types are added to Workout
    var isTimeBased: Bool {
        !workoutTime.isEmpty
    }

    // TODO: - Delete this function when proper types are added to Workout
    var workoutLengthSeconds: TimeInterval {

        var multiplier: TimeInterval = 1
        var totalSeconds: TimeInterval = 0
        for component in workoutTime.split(separator: ":").reversed() {
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


// MARK: - Identifiable Implementation

extension Workout: Identifiable{
    
    var id: ObjectIdentifier {
        // Don't worry about whats happening here.
        return .init(date as NSDate)
    }
}

// MARK: - Codable Implementation

extension Workout: Codable {
    // Codable is automatically implemented IF AND ONLY IF
    // all properties on the struct are also codable
    // complient.
}

// MARK: - Hashable Implementation

extension Workout: Hashable {
    // Hashable is automatically implemented IF AND ONLY IF
    // all properties on the struct are also Hashable
    // complient.
}

