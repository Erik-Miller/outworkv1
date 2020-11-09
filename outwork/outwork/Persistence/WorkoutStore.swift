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

        self.workoutResults = [WorkoutResult(id: "1", workoutResultTime: "10:00", workoutResultReps: "", workoutRating: true, workoutResultNotes: "Super tired today"),
                               WorkoutResult(id: "2", workoutResultTime: "", workoutResultReps: "50", workoutRating: true, workoutResultNotes: "This is a super long set of notes from a workout that will test the limits of a row view"),
                               WorkoutResult(id: "3", workoutResultTime: "10:00", workoutResultReps: "", workoutRating: true, workoutResultNotes: ""),]
        
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
        self.workouts = [Workout(workoutTitle: "Workout Title", workoutDescription: "This is a workout description", workoutTime: "10:00", workoutRounds: "", workoutMovements: [WorkoutMovement(id: "", movementName: "Thruster", movementWeight: "135", movementReps: "50")]),
                         Workout(workoutTitle: "Workout Title", workoutDescription: "This is a workout description", workoutTime: "10:30", workoutRounds: "10", workoutMovements: [WorkoutMovement(id: "", movementName: "OHS", movementWeight: "95", movementReps: "50")]),
                         Workout(workoutTitle: "Workout Title", workoutDescription: "This is a workout description", workoutTime: "10:00", workoutRounds: "", workoutMovements: [WorkoutMovement(id: "", movementName: "Air Squat", movementWeight: "", movementReps: "50")])]

        save()
    }
}

extension WorkoutStore {

    func totalTime(workoutTime: String, workoutResultTime: String) -> TimeInterval {
        return workouts
            .filter { $0.isTimeBased }
            .map { $0.workoutLengthSeconds }
            .reduce(0, +)
        +
        workoutResults
            .filter { $0.isTimeBased }
            .map { $0.workoutLengthSeconds }
            .reduce(0, +)
    }
   
}
