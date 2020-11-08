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
    
    var workoutMovements = [
        "Air Squat",
        "Back extension",
        "Back squat",
        "Bar Muscle up",
        "Barbell bent over row",
        "Barbell Turkish Get-up",
        "Bench press Clean",
        "Box jump",
        "Broad jump",
        "Burpee",
        "Burpee – Bar muscle-up",
        "Burpee – Box jump",
        "Burpee – Chest-to-bar Pull-up – Push-up",
        "Burpee – Chest-to-bar Pull-up – Ring dip",
        "Burpee – Chest-to-bar Pull-up – Static dip",
        "Burpee – Lateral Jump",
        "Burpee – Muscle-up",
        "Burpee – Pull-up – Push-up",
        "Burpee – Pull-up – Ring dip",
        "Burpee – Pull-up – Static dipring-dips",
        "Burpee – Ring row",
        "Burpee – Ring row – Push-up",
        "Burpee – Ring row – Static dip",
        "Burpee – Toes-to-bar",
        "Burpee Pull-up",
        "Chest-to-bar pull-up",
        "Clean & Jerk Cluster",
        "Deadlift",
        "Deficit push-up",
        "Dumbbell",
        "Dumbbell Clean & Jerk",
        "Dumbbell Deadlift",
        "Dumbbell front squat",
        "Dumbbell Jerk",
        "Dumbbell power clean",
        "Dumbbell Push Press",
        "Dumbbell shoulder press",
        "Dumbbell Shoulder to overhead",
        "Dumbbell Squat Clean",
        "Dumbbell Sumo deadlift high pull",
        "Dumbbell Swing",
        "Dumbbell Thruster",
        "Dumbbell Turkish Get-up",
        "Dumbbell Waiter walk",
        "Farmer carry",
        "Front squat",
        "GHD sit-up",
        "GHD Wall ball (5kgs/11lbs medball)",
        "Goblet squat (16 kg KB)",
        "Goblet squat (24 kg KB)",
        "Goblet squat (32 kg KB)",
        "Good morning",
        "Ground to Overhead",
        "Handstand",
        "Handstand push-up",
        "Handstand walk",
        "Hang power clean",
        "Hang power snatch",
        "Hang squat clean",
        "Hang squat clean",
        "Hanging hip touches",
        "Hanging ring extension",
        "Hip extension",
        "Hip-Back extension",
        "Inverted Burpee",
        "Jerk",
        "Jumping jack",
        "Jumping Pull-up",
        "Kettlebell snatch (16 kg KB)",
        "Kettlebell snatch (24 kg KB)",
        "Kettlebell swing (16 kg KB)",
        "Kettlebell swing (24 kg KB)",
        "Kettlebell swing (32 kg KB)",
        "Knees to elbowsRope Climb 2",
        "L-pull-up",
        "Ladies’ push-up",
        "Lunge Lying leg raises",
        "Medicine ball clean (10kgs/22lbs medball)",
        "Medicine ball clean (5kgs/11lbs medball)",
        "Muscle up",
        "One-arm Dumbbell Snatch",
        "One-arm kettlebell swing (16 kg KB)",
        "Overhead squat",
        "Overhead walk",
        "Overhead walking lunges",
        "Overhead walking lunges (with dumbbells)",
        "Pistol Pistol progression",
        "Plank",
        "Power clean",
        "Power snatch",
        "Pull-up (Assisted)",
        "Pull-up Push-up",
        "Push Press Shoulder press",
        "Ring dip",
        "Ring L-sit",
        "Ring pull-up",
        "Ring row",
        "Ring Tuck hold (L-sit progression)",
        "Rope climb",
        "Rowing",
        "Running",
        "Shoulder to overhead",
        "Sit-up",
        "Sit-up Wall ball (5kgs/11lbs medball)",
        "Snatch Snatch balance",
        "Sots press",
        "Stair step ascent",
        "Stair step descent",
        "Static bar L-sit",
        "Static bar Tuck hold (L-sit progression)",
        "Static Dip",
        "Static hang",
        "Strict pull-up",
        "Strict Ring pull-up",
        "Sumo deadlift high pull",
        "Superman",
        "Swimming",
        "Thruster",
        "Toes-to-bar",
        "Toes-to-rings",
        "Tuck jump",
        "Turkish Get-up (16 kg KB)",
        "Turkish Get-up (24 kg KB)",
        "Turkish Get-up (32 kg KB)",
        "Two-hand dumbbell Bent over row",
        "Walking Lunge",
        "Wall climb",
        "Zercher squat"
        ]
    
    // MARK: - Field States
    @State var newWorkoutTitle: String = ""
    @State var newWorkoutDescription: String = ""
    @State var workoutPrioritySelector = 0
    @State var newWorkoutRounds: String = ""
    @State var newWorkoutTime: String = ""
    
    @State var selectedMovement = 0
    @State var newMovementWeight: String = ""
    @State var newMovementReps: String = ""
    @State var newMovementDistance: String = ""
    @State var newMovementCalories: String = ""
    
    
    // MARK: - View States
    @State private var showAddWorkoutView = false
    
    @State private var movementCounter = 1
    @State var addWorkoutMovements: [WorkoutMovement] = []
    
    //MARK: Date Formatting
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
                        
                            Picker(selection: $selectedMovement, label: Text("Movement")) {
                            ForEach(0 ..< workoutMovements.count) {
                                Text(self.workoutMovements[$0])
                            }
                            }
                        
                        
                        HStack{
                            TextField("Weight (lbs)", text: $newMovementWeight)
                            TextField("Reps", text: $newMovementReps)
                        }
                        HStack{
                            TextField("Distance (meters)", text: $newMovementDistance)
                            TextField("Calories", text: $newMovementCalories)
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
                    
                }.frame(height: 80).background(Color.black)
                
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
    //addWorkoutMovements.append(WorkoutMovement(movementName: workoutMovements[selectedMovement], movementWeight: newMovementWeight, movementReps: newMovementReps))
    addWorkoutMovements.append(WorkoutMovement(movementName: workoutMovements[selectedMovement], movementWeight: newMovementWeight, movementReps: newMovementReps, movementCalories: newMovementCalories, movementDistance: newMovementDistance))
    
    //self.newMovementName = ""
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


