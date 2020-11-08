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
    @State var newMovementName: String = ""
    @State var newMovementWeight: String = ""
    @State var newMovementReps: String = ""
    @State var newMovementDistance: String = ""
    @State var newMovementCalories: String = ""
    
    
    // MARK: - View States
    @State private var showAddWorkoutView = false
    
    @State private var movementCounter = 1
    @State var addWorkoutMovements: [WorkoutMovement] = []
    
    
    //MARK: Data Formatting
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
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
    
    
    
    //Add New Workout Sheet
    var AddWorkoutView : some View {
        NavigationView{
            VStack{
                Form{
                    Section(header: Text("Workout Details")){
                        TextField("Workout Name", text: self.$newWorkoutTitle)
                        TextField("Workout Description (optional)", text: self.$newWorkoutDescription)
                        Picker(selection: $workoutPrioritySelector, label: Text("Workout Priority"), content: {
                            Text("Time Priority").tag(0)
                            Text("Work Priority").tag(1)
                        }).pickerStyle(SegmentedPickerStyle()).padding((EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10)))
                        if workoutPrioritySelector == 0 {
                            TextField("Time to Complete (in minutes)", text: self.$newWorkoutTime)
                        }
                        else {
                            TextField("Rounds to Complete", text: self.$newWorkoutRounds)
                        }
                    }
                    Section(header: Text("movements")){
                            ForEach(0..<movementCounter, id: \.self) { index in
                                TextField("Movement", text: $newMovementName)
                                HStack{
                                    TextField("Weight (in lbs)", text: $newMovementWeight)
                                    TextField("Reps", text: $newMovementReps)
                                }
                                HStack{
                                    TextField("Distance (in meters)", text: $newMovementDistance)
                                    TextField("Calories", text: $newMovementCalories)
                                }
                            }
                            Button(action: addNewMovementView, label: {
                                Text("Add Movement")
                                    .padding(.vertical)
                            })
                    }
                }
                VStack{
                    if addWorkoutMovements.count > 0{
                        List{
                            ForEach(self.addWorkoutMovements, id: \.self) { workoutMovement in
                                VStack{
                                    HStack{
                                        if let workoutName = workoutMovement.movementName, !workoutName.isEmpty {
                                            Text("\(workoutMovement.movementName)")
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
                        }
                        .foregroundColor(.pink)
                        .frame(maxHeight: 140)
                        .animation(.easeInOut(duration: 0.5))
                    }
                }
                VStack(spacing: 0){
                    HStack{
                        Spacer()
                        Button(action: withAnimation{self.addNewWorkout}, label: {
                            Text("Add Workout")
                                .padding(.bottom, 10)
                        })
                        Spacer()
                        
                    }.frame(height: 80).background(Color.pink).foregroundColor(.white)
                    
                }
            }.navigationBarTitle("Add Workout")
            .accentColor(.pink)
            .edgesIgnoringSafeArea(.all)
        }
    }
    func deleteMovement(at offsets: IndexSet){
        addWorkoutMovements.remove(atOffsets: offsets)
        self.workoutStore.save()
    }
    
    //MARK: TODO: Add empty field error handling
    func addNewMovementView() {
        //movementCounter += 1
        addWorkoutMovements.append(WorkoutMovement(movementName: newMovementName, movementWeight: newMovementWeight, movementReps: newMovementReps))
        
        self.newMovementName = ""
        self.newMovementReps = ""
        self.newMovementWeight = ""
    }
    
    func addNewWorkout() {
        //MARK: - TODO: If title is empty, insert date of workout
        
        workoutStore.workouts.append(
            Workout(workoutTitle: newWorkoutTitle, workoutDescription: newWorkoutDescription, workoutTime: newWorkoutTime, workoutRounds: newWorkoutRounds, workoutMovements: addWorkoutMovements))
        
        self.workoutStore.save()
        print("Item saved")
        self.newWorkoutTitle = ""
        self.newWorkoutDescription = ""
        self.addWorkoutMovements = []
        self.showAddWorkoutView.toggle()
        self.newWorkoutTime = ""
        self.newWorkoutRounds = ""
        self.workoutPrioritySelector = 0
    }
    
 
}


struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView()
    }
}


