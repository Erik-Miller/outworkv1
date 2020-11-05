//
//  WorkoutStore.swift
//  outwork
//
//  Created by Chris Feher on 2020-10-29.
//

import Foundation

class WorkoutStore : ObservableObject {
    @Published var workouts = [Workout]()
    @Published var workoutResults = [WorkoutResult]()
    @Published var workoutMovements = [WorkoutMovement]()

    init(){

        self.workouts = DataStore.readDataFromDisk()
        if workouts.isEmpty {
            seed()
        }

        self.workoutResults = [WorkoutResult(id: "1", workoutTime: "600", workoutReps: ""),
                               WorkoutResult(id: "2", workoutTime: "900", workoutReps: "56"),
                               WorkoutResult(id: "3", workoutTime: "", workoutReps: "56"),]
        
        self.workoutMovements = [WorkoutMovement(movementName: "Pull up", movementWeight: "", movementReps: "50"),
                                 WorkoutMovement(movementName: "Air Squat", movementWeight: "", movementReps: "50"),
                                 WorkoutMovement(movementName: "Push up", movementWeight: "", movementReps: "50")]
    }

    func save() {
        DataStore.writeDataToDisk(data: workouts)
    }

}

extension WorkoutStore {

    func seed() {
        self.workouts = [Workout(workoutTitle: "Workout Title", workoutDescription: "This is a workout description", workoutMovements: [WorkoutMovement(id: "", movementName: "Thruster", movementWeight: "135", movementReps: "50")]),
                         Workout(workoutTitle: "Workout Title", workoutDescription: "This is a workout description", workoutMovements: [WorkoutMovement(id: "", movementName: "OHS", movementWeight: "95", movementReps: "50")]),
                         Workout(workoutTitle: "Workout Title", workoutDescription: "This is a workout description", workoutMovements: [WorkoutMovement(id: "", movementName: "Air Squat", movementWeight: "", movementReps: "50")])]

        save()
    }
}

extension WorkoutStore {
    
    //MARK: - Create a function that shows the reps accumulate over time
    func totalReps(workouts: [Workout]) -> String {
//        Iterate through workouts
//            Iterate through workout movements
//            Convert Workout Reps to Int and Append to Rep Array
//        Sum up Array of Reps
//        Convert final value back to String
      return "Reps"
    }
    
    //MARK: - My Attempt at this
    func totalReps2(workouts: [Workout]) -> String {
        
        var repCounts:[Int] = []
        let totalReps = repCounts.reduce(0, +)
        let totalRepString = String(totalReps)
        
        for workout in workouts {
            for movement in workoutMovements {
                let repCount = Int(movement.movementReps) ?? 0
                repCounts.append(repCount)
            }
        }
        return totalRepString
    }
    
    func weeklyReps(workouts: [Workout]) -> String {
     
        return "Reps"
    }
}
