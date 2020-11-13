//
//  WorkoutListViewModel.swift
//  outwork
//
//  Created by Erik Miller on 11/12/20.
//

import Foundation
import Combine

class WorkoutListViewModel: ObservableObject {
    @Published var workoutItemViewModels = [WorkoutItemViewModel]()
    
    init(){
        self.workoutItemViewModels = [WorkoutItemViewModel]()
        
        if workoutItemViewModels.isEmpty {
            seed()
        }
    }
    func seed() {
        self.workoutItemViewModels =
            
            [WorkoutItemViewModel(workout: Workout(workoutTitle: "Workout 1", workoutDescription: "This is a workout description", workoutTime: "10:00", workoutRounds: "", workoutMovements: [WorkoutMovement(id: "", movementName: "Thruster", movementWeight: "135", movementReps: "50")])),
                                      
             WorkoutItemViewModel(workout: Workout(workoutTitle: "Workout 2", workoutDescription: "This is a workout description", workoutTime: "10:30", workoutRounds: "10", workoutMovements: [WorkoutMovement(id: "", movementName: "OHS", movementWeight: "95", movementReps: "50")])),
                                      
             WorkoutItemViewModel(workout: Workout(workoutTitle: "Workout 3", workoutDescription: "This is a workout description", workoutTime: "10:00", workoutRounds: "", workoutMovements: [WorkoutMovement(id: "", movementName: "Air Squat", movementWeight: "", movementReps: "50")], workoutResults: [WorkoutResult(id: "", workoutResultTime: "", workoutResultReps: "300", workoutRating: true, workoutResultNotes: "Tough workout")]))]
    }
}


