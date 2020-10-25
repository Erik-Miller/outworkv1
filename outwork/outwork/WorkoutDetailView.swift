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
        Text("\(workout.workoutItem)")
        Text("Workout Duration")
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView()
    }
}
