//
//  WorkoutModel.swift
//  outwork
//
//  Created by Erik Miller on 10/25/20.
//

import Foundation
import Combine

struct Workout : Identifiable, Decodable, Encodable, Hashable {
    var id = String()
    var workoutTitle = String()
    var workoutDescription = String()
    
}

struct WorkoutList{
    var workoutList: [Workout: [WorkoutResult]]
}


struct WorkoutResult: Identifiable {
    var id = String()
    var workoutTime = String()
    var workoutReps = String()
}



// Example Workouts

//Workout for Time

//For time:
//
//1,500-meter row
//Then, 5 rounds of:
//10 bar muscle-ups
//7 push jerks
//
//♀ 145 lb. ♂ 235 lb.

//Workout for Reps/Rounds

//Complete as many rounds as possible in 7 minutes of:
//
//50 double-unders
//10 overhead squats
//
//♀ 95 lb. ♂135 lb.
//


    
    //MARK: TODO - Figure out how to present two different types of workout forms
//    enum WorkoutType: String {
//        case timePriority, workPriority
//    }
//}

class WorkoutStore : ObservableObject {
    @Published var workouts = [Workout]()
    @Published var workoutResults = [WorkoutResult]()
    
    init(){
        
        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            if let decoded = try? JSONDecoder().decode([Workout].self,
                                                       from: data) {
                self.workouts = decoded
                return
            }
        }
        
        self.workouts = [Workout(id: "1", workoutTitle: "Workout Title", workoutDescription: "This is a workout description"),
                         Workout(id: "2", workoutTitle: "Workout Title", workoutDescription: "This is a workout description"),
                         Workout(id: "3", workoutTitle: "Workout Title", workoutDescription: "This is a workout description")]
        
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

