//
//  WorkoutStore.swift
//  outwork
//
//  Created by Chris Feher on 2020-10-29.
//

import Foundation

class WorkoutViewModel: ObservableObject, Identifiable {
    @Published var workout: Workout
    var id = ""
    
    init(workout: Workout){
        self.workout = workout
    }
    
}

class WorkoutListViewModel: ObservableObject {
    @Published var workouts: [WorkoutViewModel]
    
    
    
    init(workouts: [WorkoutViewModel]){
        self.workouts = [WorkoutViewModel(workout: Workout(workoutTitle: "Workout Title", workoutDescription: "This is a workout description", workoutTime: "10:00", workoutRounds: "", workoutMovements: [WorkoutMovement(id: "", movementName: "Thruster", movementWeight: "135", movementReps: "50")])),
                         WorkoutViewModel(workout: Workout(workoutTitle: "Workout Title", workoutDescription: "This is a workout description", workoutTime: "10:30", workoutRounds: "10", workoutMovements: [WorkoutMovement(id: "", movementName: "OHS", movementWeight: "95", movementReps: "50")])),
                         WorkoutViewModel(workout: Workout(workoutTitle: "Workout Title", workoutDescription: "This is a workout description", workoutTime: "10:00", workoutRounds: "", workoutMovements: [WorkoutMovement(id: "", movementName: "Air Squat", movementWeight: "", movementReps: "50")]))]
    }
}


class WorkoutStore : ObservableObject {
    @Published var workouts = [Workout]()
    //MARK: - Removed these because they are a part of the workout model
    //@Published var workoutResults = [WorkoutResult]()
    //@Published var workoutMovements = [WorkoutMovement]()

    

    func save() {
        DataStore.writeDataToDisk(data: workouts)
    }
}

// Seed workouts for now
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
        
    // Commented out as this creates an error
//        +
//        workout
//            .filter { $0.workoutResult.workoutRating == true }
//            .map { $0.workoutLengthSeconds }
//            .reduce(0, +)
    }
}
