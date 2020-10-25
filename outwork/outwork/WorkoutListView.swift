//
//  WorkoutListView.swift
//  outwork
//
//  Created by Erik Miller on 10/25/20.
//

import SwiftUI
import Combine

struct WorkoutListView: View {
    @ObservedObject var workoutStore = WorkoutStore()
    @State var newWorkout: String = ""
    @State private var addWorkoutSheet = false
    
    
    //MARK: Add New Workout Sheet
    var AddWorkoutView : some View {
        VStack{
            Spacer()
            TextField("Enter a workout name", text: self.$newWorkout)
                .padding()
            Button(action: self.addNewWorkout, label: {
                Text("Add Workout")
            })
            Spacer()
        }.background(Color.pink).edgesIgnoringSafeArea(.all).foregroundColor(.white)
    }
    
    //MARK: Add New Workout to workoutStore
    func addNewWorkout() {
        workoutStore.workouts.append(Workout(id: String(workoutStore.workouts.count + 1), workoutItem: newWorkout))
        self.newWorkout = ""
        self.addWorkoutSheet.toggle()
    }
    
    //MARK: Main Workout List View
    var body: some View {
        NavigationView {

                
            VStack{
                List{
                    ForEach(self.workoutStore.workouts) { workout in
                        NavigationLink(destination: Text(workout.workoutItem)) {
                            Text(workout.workoutItem)
                                .padding()
                        }
                    }.onMove(perform: self.move)
                    .onDelete(perform: self.delete)
                    
                }
                
            }.navigationBarTitle("Workouts")
            //.navigationBarItems(trailing: EditButton())
            .navigationBarItems(trailing: Button(action: {self.addWorkoutSheet.toggle()}, label: {
                Text("Add Workout").accentColor(.pink)
            }))
        }
        
        .sheet(isPresented: $addWorkoutSheet, content: {
            AddWorkoutView
        })
        
    }
    func move(from source: IndexSet, to destination : Int){
        workoutStore.workouts.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete(at offsets: IndexSet){
        workoutStore.workouts.remove(atOffsets: offsets)
    }
    
}


struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView()
    }
}
