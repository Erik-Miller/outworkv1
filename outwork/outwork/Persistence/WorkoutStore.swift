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
