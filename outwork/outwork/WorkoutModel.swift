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
    var workoutTitle = String()
    var workoutDescription = String()
}
    
    //MARK: TODO - Figure out how to present two different types of workout forms
//    enum WorkoutType: String {
//        case timePriority, workPriority
//    }
//}

class WorkoutStore : ObservableObject {
    @Published var workouts = [Workout]()
    
    init(){
        self.workouts = [Workout(id: "1", workoutTitle: "Workout Title", workoutDescription: "This is a workout description"),
                         Workout(id: "2", workoutTitle: "Workout Title", workoutDescription: "This is a workout description"),
                         Workout(id: "3", workoutTitle: "Workout Title", workoutDescription: "This is a workout description")]
    }
    
}

