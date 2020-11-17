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
        cancellableSubscription = workoutStore.$workouts.sink { [unowned self] workouts in
            self.workoutListItems = workouts.map {
                WorkoutListItemViewModel(workout: $0, workoutStore: self.workoutStore)
            }
        }
    }
}

// MARK: - WorkoutListItemViewModel

class WorkoutListItemViewModel {

    let title: String
    let description: String
    let date: Date
    let detailViewModel: WorkoutDetailViewModel

    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }

    init(workout: Workout, workoutStore: WorkoutStore) {
        self.title = workout.title
        self.description = workout.description
        self.date = workout.date
        self.detailViewModel = WorkoutDetailViewModel(
            workout: workout,
            workoutStore: workoutStore
        )
    }
}

// MARK: - Identifiable Impl

extension WorkoutListItemViewModel: Identifiable { }
