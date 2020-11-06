//
//  MockWorkout.swift
//  outwork
//
//  Created by Chris Feher on 2020-10-29.
//

import Foundation

extension Workout {

    static var mockWorkout: Workout {
        return Workout(
            workoutTitle: "Squat Thrusts",
            workoutDescription: "This is a placeholder workout description.",
            workoutTime: "",
            workoutRounds: "",
            workoutMovements: [WorkoutMovement(id: "", movementName: "Thruster", movementWeight: "135", movementReps: "50")]
            
        )
    }
}
