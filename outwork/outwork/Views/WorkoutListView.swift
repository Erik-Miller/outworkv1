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
    @State var workout = Workout.mockWorkout
    
    
    
    // MARK: - Field States
    @State var newWorkoutTitle: String = ""
    @State var newWorkoutDescription: String = ""
    
    @State var workoutPrioritySelector = 0
    @State var newWorkoutRounds: String = ""
    @State var newWorkoutTime: String = ""
    
    @State var selectedMovement = 0
    var workoutMovements = ["Clean & Jerk", "Snatch", "Air Squats"]
    @State var newMovementReps: String = ""
    @State var newMovementName: String = ""
    @State var newMovementWeight: String = ""
    
    
    // MARK: - View States
    @State private var showAddWorkoutView = false
    
    @State private var movementCounter = 1
    @State var addWorkoutMovements: [WorkoutMovement] = []
    
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
    
    //MARK: Data Formatting
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    
    
    //Add New Workout Sheet
    var AddWorkoutView : some View {
        VStack{
            Text("Add Workout")
                .font(.title).fontWeight(.bold).padding((EdgeInsets(top: 40, leading: 0, bottom: 20, trailing: 0)))
            TextField("Enter a workout name", text: self.$newWorkoutTitle)
                .padding()
            Divider().padding(0)
            TextField("Enter a workout description (optional)", text: self.$newWorkoutDescription)
                .padding()
            Divider().padding(0)
            Picker(selection: $workoutPrioritySelector, label: Text("Workout Priority"), content: {
                Text("Time Priority").tag(0).padding()
                Text("Work Priority").tag(1).padding()
            }).pickerStyle(SegmentedPickerStyle()).padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            
            if workoutPrioritySelector == 0 {
                TextField("Enter workout time", text: self.$newWorkoutTime)
                    .padding()
            }
            else {
                TextField("Enter workout rounds", text: self.$newWorkoutRounds)
                    .padding()
            }
            Divider()
            
            VStack{
                VStack{
                    AddMovementFields
                    Button(action: addNewMovementView, label: {
                        Text("Add Movement")
                            .padding()
                    })
                }
                Divider()
                VStack(spacing: 0){
                    if addWorkoutMovements.count > 0{
                        List{
                            ForEach(self.addWorkoutMovements, id: \.self) { workoutMovement in
                                VStack{
                                    HStack{
                                        if let workoutName = workoutMovement.movementName, !workoutName.isEmpty {
                                            Text(workoutMovement.movementName)
                                        }
                                        if let workoutWeight = workoutMovement.movementWeight, !workoutWeight.isEmpty {
                                            Text("@\(workoutMovement.movementWeight) Lbs")
                                        }
                                        if let workoutReps = workoutMovement.movementReps, !workoutReps.isEmpty {
                                            Text("for \(workoutMovement.movementReps) Reps")
                                        }
                                    }
                                }.padding()
                            }.onDelete(perform: deleteMovement).padding(0)
                        }.listStyle(InsetGroupedListStyle()).padding(0).foregroundColor(.pink)
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: self.addNewWorkout, label: {
                            Text("Add Workout")
                                .padding()
                        })
                        Spacer()
                        
                    }.frame(height: 100).background(Color.black)
                }
            }
        }.navigationBarTitle("Add Workout").accentColor(.pink)
        .edgesIgnoringSafeArea(.all).foregroundColor(.white)
        
        
    }
    func deleteMovement(at offsets: IndexSet){
        addWorkoutMovements.remove(atOffsets: offsets)
        self.workoutStore.save()
    }
    
    //MARK: TODO: Add empty field error handling
    func addNewMovementView() {
        //movementCounter += 1
        addWorkoutMovements.append(WorkoutMovement(movementName: newMovementName, movementWeight: newMovementWeight, movementReps: newMovementReps))
        
        newMovementName = ""
        newMovementReps = ""
        newMovementWeight = ""
        newWorkoutTime = ""
        newWorkoutRounds = ""
        workoutPrioritySelector = 0
    }
    
    func addNewWorkout() {
        //MARK: - TODO: If title is empty, insert date of workout
        
        workoutStore.workouts.append(
            Workout(workoutTitle: newWorkoutTitle, workoutDescription: newWorkoutDescription, workoutTime: newWorkoutTime, workoutRounds: newWorkoutRounds, workoutMovements: addWorkoutMovements))
        
        let currentWorkoutWithMovements = workoutStore.workouts
        print(currentWorkoutWithMovements)
        self.workoutStore.save()
        print("Item saved")
        self.newWorkoutTitle = ""
        self.addWorkoutMovements = []
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
                                    .padding(.top, 5)
                                Text(dateFormatter.string(from: workout.date))
                                    .font(.caption)
                                    .padding(.top, 5)
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


