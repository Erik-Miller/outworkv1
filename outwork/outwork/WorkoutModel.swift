//
//  WorkoutModel.swift
//  outwork
//
//  Created by Erik Miller on 10/25/20.
//

import Foundation
import Combine

struct Workout : Identifiable {
    var id = String()
    var workoutItem = String()
}

class WorkoutStore : ObservableObject {
    @Published var workouts = [Workout]()
    
    init(){
        self.workouts = [Workout(id: "1", workoutItem: "This is a workout item"), Workout(id: "2", workoutItem: "This is a workout item"), Workout(id: "3", workoutItem: "This is a workout item")]
    }
    
}

