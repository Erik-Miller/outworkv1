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

    func formattedTotalTime() -> String {
        let totalTimeInSeconds = NSNumber(value: totalWorkoutTime())
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: totalTimeInSeconds) ?? ""
    }

    // this function should live in some sort of view model.
    func totalWorkoutTime() -> TimeInterval {
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
