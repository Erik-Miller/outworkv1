//
//  WorkoutViewModel.swift
//  outwork
//
//  Created by Chris Feher on 2020-11-16.
//

import Combine
import Foundation
import SwiftUI

// MARK: - WorkoutListViewModel

class WorkoutListViewModel {

    @Published var workoutListItems = [WorkoutListItemViewModel]()

    private let workoutStore: WorkoutStore
    private var cancellableSubscription: AnyCancellable?

    deinit {
        cancellableSubscription?.cancel()
    }

    init(workoutStore: WorkoutStore) {
        self.workoutStore = workoutStore
        setupSubscriptions()
    }

    func setupSubscriptions() {
        cancellableSubscription = workoutStore.$workouts.sink { [weak self] workouts in
            self?.workoutListItems = workouts.map {
                WorkoutListItemViewModel(workout: $0)
            }
        }
    }
}

// MARK: - WorkoutListItemViewModel

class WorkoutListItemViewModel {
    let title: String
    let description: String
    let date: Date

    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }

    init(workout: Workout) {
        self.title = workout.title
        self.description = workout.description
        self.date = workout.date
    }
}

// MARK: - Identifiable Impl

extension WorkoutListItemViewModel: Identifiable { }
