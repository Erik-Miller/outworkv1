//
//  WorkoutListView.swift
//  outwork
//
//  Created by Erik Miller on 10/25/20.
//

import SwiftUI
import Combine

struct WorkoutListView: View {
    @StateObject var workoutStore = WorkoutStore()
    @State var newWorkoutTitle: String = ""
    @State var newWorkoutDescription: String = ""
    @State private var addWorkoutSheet = false
    
    
    //Add New Workout Sheet
    var AddWorkoutView : some View {
        VStack{
            Text("Add Workout").font(.title2).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.white).padding(50)
            TextField("Enter a workout name", text: self.$newWorkoutTitle)
                .padding()
            TextField("Enter a workout description", text: self.$newWorkoutDescription)
                .padding()
            Button(action: self.addNewWorkout, label: {
                Text("Add Workout")
            }).padding()
            Spacer()
        }.navigationBarTitle("Add Workout").accentColor(.white)
        .background(Color.pink).edgesIgnoringSafeArea(.all).foregroundColor(.white)
    }
    
    //MARK: TODO: Add empty field error handling
    func addNewWorkout() {
        workoutStore.workouts.append(
            Workout(
                workoutTitle: newWorkoutTitle,
                workoutDescription: newWorkoutDescription
            )
        )
        self.workoutStore.save()
        print("Item saved")
        self.newWorkoutTitle = ""
        self.addWorkoutSheet.toggle()
    }
    
    //MARK: Main Workout List View
    var body: some View {
        NavigationView {
            
            
            VStack{
                List{
                    ForEach(self.workoutStore.workouts) { workout in
                        NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                            VStack(alignment: .leading){
                                Text(workout.title)
                                Text(workout.description)
                            }.padding()
                        }
                    }.onMove(perform: self.move)
                    .onDelete(perform: self.delete)
                }.listStyle(GroupedListStyle())
            }
            .navigationTitle("Workouts")
            //.navigationBarItems(trailing: EditButton())
            .navigationBarItems(trailing: Button(action: {self.addWorkoutSheet.toggle()}, label: {
                Text("Add Workout").accentColor(.pink)
            }))
        }.accentColor( .white)
        
        .sheet(isPresented: $addWorkoutSheet, content: {
            AddWorkoutView
        })
        
    }
    func move(from source: IndexSet, to destination : Int){
        workoutStore.workouts.move(fromOffsets: source, toOffset: destination)
        self.workoutStore.save()
    }
    
    func delete(at offsets: IndexSet){
        workoutStore.workouts.remove(atOffsets: offsets)
        self.workoutStore.save()
    }
    
}


struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView()
    }
}

