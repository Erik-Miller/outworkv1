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
    
    init(
        workoutTitle: String,
        workoutDescription: String,
        completionDate: Date = Date(),
        workoutTime: String,
        workoutRounds: String,
        workoutMovements: [WorkoutMovement]
       
    ) {
        self.title = workoutTitle
        self.description = workoutDescription
        self.date = completionDate
        self.workoutTime = workoutTime
        self.workoutRounds = workoutRounds
        self.workoutMovements = workoutMovements
        
    }
}

struct WorkoutList{
    var workoutList:[Workout: [WorkoutResult]]
}

struct WorkoutResult: Identifiable {
    var id = String()
    var workoutTime = String()
    var workoutReps = String()
}

struct WorkoutMovement: Identifiable, Codable, Hashable {
    var id = String()
    var movementName = String()
    var movementWeight = String()
    var movementReps = String()
}

// MARK: - Identifiable Implementation

extension Workout: Identifiable {
    
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

// Example Workout

//Workout for Time

//For time:
//
//1,500-meter row
//Then, 5 rounds of:
//10 bar muscle-ups
//7 push jerks
//
//♀ 145 lb. ♂ 235 lb.

//Example Results
//Time in seconds (or time in minutes and seconds such as 3:35)


//Example Workout

//Workout for Reps/Rounds

//Complete as many rounds as possible in 7 minutes of:
//
//50 double-unders
//10 overhead squats
//
//♀ 95 lb. ♂135 lb.

//Example Results
//Total Reps






//MARK: TODO - Figure out how to present two different types of workout forms
//    enum WorkoutType: String {
//        case timePriority, workPriority
//    }
//}


