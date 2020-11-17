//
//  WorkoutDetailViewModel.swift
//  outwork
//
//  Created by Chris Feher on 2020-11-16.
//

import Combine
import Foundation

class WorkoutDetailViewModel {

    @Published var workoutTime: String
    
    private let workoutStore: WorkoutStore
    private var workout: Workout // do not expose this
    private var cancellableSubscription: AnyCancellable?

    init(workout: Workout, workoutStore: WorkoutStore) {
        self.workoutTime = workout.workoutTime
        self.workout = workout
        self.workoutStore = workoutStore
        setupSubscriptions()
    }

    func setupSubscriptions() {
        cancellableSubscription = workoutStore.$workouts.sink { [unowned self] workouts in
            if let updatedWorkout = workouts.first(where: { $0 == self.workout }) {
                self.updateWorkout(updatedWorkout)
            }
        }
    }

    func updateWorkout(_ workout: Workout) {
        self.workout = workout
        self.title = workout.title
    }
}
