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

        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            if let decoded = try? JSONDecoder().decode([Workout].self,
                                                       from: data) {
                self.workouts = decoded
                return
            }
        }

        self.workouts = [Workout(workoutTitle: "Workout Title", workoutDescription: "This is a workout description", workoutMovement: WorkoutMovement(id: "", movementName: "Thruster", movementWeight: "135", movementReps: "50")),
                         Workout(workoutTitle: "Workout Title", workoutDescription: "This is a workout description", workoutMovement: WorkoutMovement(id: "", movementName: "Thruster", movementWeight: "135", movementReps: "50")),
                         Workout(workoutTitle: "Workout Title", workoutDescription: "This is a workout description", workoutMovement: WorkoutMovement(id: "", movementName: "Thruster", movementWeight: "135", movementReps: "50"))]

        self.workoutResults = [WorkoutResult(id: "1", workoutTime: "600", workoutReps: ""),
                               WorkoutResult(id: "2", workoutTime: "900", workoutReps: "56"),
                               WorkoutResult(id: "3", workoutTime: "", workoutReps: "56"),]
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(workouts) {
            UserDefaults.standard.set(encoded, forKey: "SaveData")
        }
    }

}
