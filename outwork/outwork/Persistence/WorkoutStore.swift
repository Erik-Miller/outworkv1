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
    
    func totalReps(workoutReps: String) -> Int {
        var totalReps: Int = Int()

        for workoutResult in workoutResults
        {
            totalReps += Int(workoutResult.workoutResultReps) ?? 0
        }
        return totalReps
    }
    
    func totalTime(workoutTime: String, workoutResultTime: String) -> Int {
        var totalResultTime: Int = Int()
        var individualResultTime: Int = Int()
        var totalWorkoutTime: Int = Int()
        var individualWorkoutTime: Int = Int()

        //MARK: - Calculate the time for Workouts with Time as a priority (reps as result)
        for workout in workouts {
            let workoutTimeComponents = workout.workoutTime.split { $0 == ":" } .map { (x) -> Int in return Int(String(x))! }
            //print("Workout time components \(workoutTimeComponents)")
            if workoutTimeComponents.count == 2 {
                let workoutTimeMinutes = Int(workoutTimeComponents[0])
                let workoutTimeSeconds = Int(workoutTimeComponents[1])
                individualWorkoutTime = (workoutTimeMinutes * 60) + workoutTimeSeconds
            }
            totalWorkoutTime += individualWorkoutTime
            //print("total workout time \(totalWorkoutTime)")
        }
        
        //MARK: - Calculate the time for Workout Results with Time as result
        for workoutResult in workoutResults {
            let workoutResultTimeComponents = workoutResult.workoutResultTime.split { $0 == ":" } .map { (x) -> Int in return Int(String(x))! }
            //print("Workout Result Time Components: \(workoutResultTimeComponents)")
            if workoutResultTimeComponents.count == 2 {
                let workoutResultTimeMinutes = Int(workoutResultTimeComponents[0])
               // print("Workout result time in minutes: \(workoutResultTimeMinutes)")
            let workoutResultTimeSeconds = Int(workoutResultTimeComponents[1])
                //print("Workout result time in seconds: \(workoutResultTimeSeconds)")
                individualResultTime = (workoutResultTimeMinutes * 60) + workoutResultTimeSeconds
                //print("Individual result time \(individualResultTime)")
            }
            totalResultTime += individualResultTime
            
        }
        print("Total workout time: \(totalWorkoutTime)")
        print("Total workout results time: \(totalResultTime)")
        let totalWorkingTime = totalResultTime + totalWorkoutTime
        return totalWorkingTime
        
    }
   
}
