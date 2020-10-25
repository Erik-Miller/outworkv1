//
//  WorkoutDetailView.swift
//  outwork
//
//  Created by Erik Miller on 10/25/20.
//

import SwiftUI

struct WorkoutDetailView: View {
    var workout = Workout()
    
    var body: some View {
        Text(workout.workoutTitle)
        Text(workout.workoutDescription)
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView()
    }
}
