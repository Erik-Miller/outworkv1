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
    
    // MARK: - Field States
    @State var newWorkoutTitle: String = ""
    @State var newWorkoutDescription: String = ""
    
    @State var newMovementReps: String = ""
    @State var newMovementName: String = ""
    @State var newMovementWeight: String = ""
    
    
    // MARK: - View States
    @State private var showAddWorkoutView = false
    
    @State private var movementCounter = 1
    var addWorkoutMovements = [WorkoutMovement]()
    
    var AddMovementFields : some View {
        VStack{
            ForEach(0..<movementCounter, id: \.self) { index in
                TextField("Movement", text: $newMovementName)
                    .padding()
                HStack{
                    TextField("Weight", text: $newMovementWeight)
                        .padding()
                    TextField("Reps", text: $newMovementReps)
                        .padding()
                }
            }
        }
    }
    
    
    
    //Add New Workout Sheet
    var AddWorkoutView : some View {
        VStack{
            Text("Add Workout")
                .font(.title).fontWeight(.bold).padding(50)
            TextField("Enter a workout name", text: self.$newWorkoutTitle)
                .padding()
            TextField("Enter a workout description", text: self.$newWorkoutDescription)
                .padding()
            Divider()
            
            VStack{
                VStack{
                    AddMovementFields
                    Button(action: addNewMovementView, label: {
                        Text("Add Movement")
                            .padding()
                    })
                }
                Spacer()
                VStack(spacing: 0){
                if workoutStore.workoutMovements.count > 0{
                    List{
                        ForEach(workoutStore.workoutMovements, id: \.self) { workoutMovement in
                            VStack{
                                HStack{
                                    Text(workoutMovement.movementName)
                                    Text("\(workoutMovement.movementWeight) Lbs")
                                    Text("\(workoutMovement.movementReps) Reps")
                                }
                            }.padding()
                        }.padding(0)
                    }.listStyle(InsetGroupedListStyle()).padding(0)
                    
                }
                }
                VStack{
                    HStack{
                        Spacer()
                        Button(action: self.addNewWorkout, label: {
                            Text("Add Workout")
                                .padding()
                        })
                        Spacer()
                    }
                }.frame(height: 80).background(Color.black)
            }

            
            
        }.navigationBarTitle("Add Workout").accentColor(.pink)
        .background(Color.pink).edgesIgnoringSafeArea(.all).foregroundColor(.white)
    }
    
    //MARK: TODO: Add empty field error handling
    func addNewMovementView() {
        //movementCounter += 1
        workoutStore.workoutMovements.append(WorkoutMovement(movementName: newMovementName, movementWeight: newMovementWeight, movementReps: newMovementReps))
        self.newMovementName = ""
        self.newMovementReps = ""
        self.newMovementWeight = ""
        
    }
    
    func addNewWorkout() {
        workoutStore.workouts.append(
            Workout(workoutTitle: newWorkoutTitle, workoutDescription: newWorkoutDescription, workoutMovements: addWorkoutMovements))
        
        self.workoutStore.save()
        print("Item saved")
        self.newWorkoutTitle = ""
        self.showAddWorkoutView.toggle()
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
            .navigationBarItems(trailing: Button(action: {self.showAddWorkoutView.toggle()}, label: {
                Text("Add Workout").accentColor(.pink)
            }))
        }.accentColor( .pink)
        
        .sheet(isPresented: $showAddWorkoutView, content: {
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


