//
//  AddWorkoutView.swift
//  outwork
//
//  Created by Erik Miller on 10/25/20.
//

import SwiftUI

var AddWorkoutView : some View {
    @State private var addWorkoutSheet = false
    
    VStack{
        TextField("Enter a workout name", text: self.$newWorkout)
        Button(action: self.addNewWorkout, label: {
            Text("Add Workout")
        })
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView()
    }
}
