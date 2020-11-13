//
//  WorkoutItemViewModel.swift
//  outwork
//
//  Created by Erik Miller on 11/12/20.
//

import Foundation
import Combine

class WorkoutItemViewModel: ObservableObject, Identifiable {
    @Published var workout: Workout
    var id = ""
    
    init(workout: Workout) {
        self.workout = workout
    }
    
}
