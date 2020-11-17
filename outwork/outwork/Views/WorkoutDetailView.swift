//
//  WorkoutDetailView.swift
//  outwork
//
//  Created by Erik Miller on 10/25/20.
//

import SwiftUI

struct WorkoutDetailView: View {
    @ObservedObject var workoutStore = WorkoutStore()
    @State var workout = Workout.mockWorkout
    //var workoutResult = WorkoutResult()
    
    @State private var addResultSheet = false
    
    @State var workoutTime = ""
    @State var workoutReps = ""
    @State var workoutResultRating = true
    @State var workoutResultNotes = ""
    
    var AddResultView : some View {
        NavigationView{
            VStack{
                Form{
                    Section(header: Text("Enter Your Score")){
                        if workout.workoutTime.isEmpty{
                            TextField("Enter the time in seconds", text: self.$workoutTime)
                                .padding()
                        }
                        else{
                            TextField("Enter total reps completed", text: self.$workoutReps)
                                .padding()
                        }
                    }
                    Section(header: Text("Rate Your Workout performance")){
                        HStack{
                            Picker(selection: $workoutResultRating, label: Text("")) {
                                Image(systemName: "hand.thumbsup").tag(true)
                                Image(systemName: "hand.thumbsdown").tag(false)
                            }.pickerStyle(SegmentedPickerStyle())
                        }.padding()
                        VStack{
                            TextField("Enter workout notes", text: $workoutResultNotes)
                                .padding(.vertical)
                        }
                    }
                }.padding(.top)
                
                VStack(spacing: 0){
                    HStack{
                        Spacer()
                        Button(action: self.addNewResult, label: {
                            Text("Add Result")
                                .padding()
                        })
                        Spacer()
                        
                    }.frame(height: 80).background(Color.pink).foregroundColor(.white)
                    
                }
            }.navigationTitle("Add Result")
        }
    }
    
    var body: some View {
        VStack{
            VStack{
                if let workoutTitle = workout.title, !workoutTitle.isEmpty {
                    Text(workout.title)
                        .font(.title)
                        .padding(.bottom)
                } else {
                    Text("Workout")
                        .font(.title)
                        .padding(.bottom)
                }
                
                if let workoutDescription = workout.description, !workoutDescription.isEmpty {
                    Text(workout.description)
                        .padding(.bottom, 5)
                        .foregroundColor(.secondary)
                }
                if let workoutTime = workout.workoutTime, !workoutTime.isEmpty {
                    Text("\(workout.workoutTime) Minutes")
                        .padding(.bottom, 5)
                }
                if let workoutRounds = workout.workoutRounds, !workoutRounds.isEmpty {
                    Text("\(workout.workoutRounds) Rounds")
                        .padding(.bottom, 5)
                    
                }
                
                ForEach(workout.workoutMovements, id: \.self) { workoutMovement in
                    VStack(alignment: .leading){
                        HStack{
                            if let workoutName = workoutMovement.movementName, !workoutName.isEmpty {
                                Text(workoutMovement.movementName)
                                    .foregroundColor(.secondary)
                            }
                            if let workoutWeight = workoutMovement.movementWeight, !workoutWeight.isEmpty {
                                Text("@\(workoutMovement.movementWeight) Lbs")
                                    .foregroundColor(.secondary)
                            }
                            if let workoutReps = workoutMovement.movementReps, !workoutReps.isEmpty {
                                Text("for \(workoutMovement.movementReps) Reps")
                                    .foregroundColor(.secondary)
                            }
                            
                        }
                    }
                }
            }.padding(.bottom, 10)
            
            
            //MARK: - Result List
            Spacer()
            Divider()
            VStack{
                HStack{
                    Text("Results")
                        .font(.title3)
                        .padding(.horizontal)
                    Spacer()
                }
            }.padding()
            Divider()
        }
        List{
            
            ForEach(workout.workoutResults) { workoutResult in
                HStack{
                    VStack(alignment: .leading){
                        if let workoutTime = workoutResult.workoutResultTime, !workoutTime.isEmpty {
                            Text("Time: \(workoutResult.workoutResultTime)")
                                .font(.headline)
                        }
                        if let workoutReps = workoutResult.workoutResultReps, !workoutReps.isEmpty {
                            Text("Reps: \(workoutResult.workoutResultReps)")
                                .font(.headline)
                        }
                        if let workoutResultNotes = workoutResult.workoutResultNotes, !workoutResultNotes.isEmpty {
                            Text(workoutResult.workoutResultNotes)
                                .padding(.top, 5)
                                .foregroundColor(.secondary)
                                .font(.body)
                        }
                    }
                    Spacer()
                    VStack{
                        if let workoutRating = workoutResult.workoutRating, workoutRating == true {
                            Image(systemName: "hand.thumbsup")
                        }
                        else {
                            Image(systemName: "hand.thumbsdown")
                            
                        }
                        Text("Rating")
                            .font(.caption)
                            .padding(.top, 5)
                        
                    }.padding()
                }.padding()
                
                
            }.onMove(perform: self.move)
            .onDelete(perform: self.delete)
        }
        Spacer()
        HStack{
            Button(action: {self.addResultSheet.toggle()}, label: {
                Spacer()
                Text("Add New Result")
                Spacer()
            }).padding().frame(height: 60).background(Color.pink).foregroundColor(.white)
        }
        
        .sheet(isPresented: $addResultSheet, content: {AddResultView})
    }
    
    func addNewResult() {
        self.workout.workoutResults.append(WorkoutResult(id: "", workoutResultTime: workoutTime, workoutResultReps: workoutReps, workoutRating: workoutResultRating, workoutResultNotes: workoutResultNotes))
        self.workoutStore.save()
        print("Item saved")
        self.workoutReps = ""
        self.workoutTime = ""
        self.addResultSheet.toggle()
        
    }
    
    func move(from source: IndexSet, to destination : Int){
        self.workoutStore.workoutResults.move(fromOffsets: source, toOffset: destination)
        self.workoutStore.save()
    }
    
    func delete(at offsets: IndexSet){
        self.workoutStore.workoutResults.remove(atOffsets: offsets)
        self.workoutStore.save()
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView()
    }
}
