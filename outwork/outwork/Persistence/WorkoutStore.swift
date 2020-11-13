//
//  WorkoutStore.swift
//  outwork
//
//  Created by Chris Feher on 2020-10-29.
//

import Foundation

class WorkoutStore : ObservableObject {
    @Published var workouts = [Workout]()

    init(){

        self.workouts = DataStore.readDataFromDisk()
    }

    func save() {
        DataStore.writeDataToDisk(data: workouts)
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
    }
}
