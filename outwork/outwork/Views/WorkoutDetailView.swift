//
//  WorkoutDetailView.swift
//  outwork
//
//  Created by Erik Miller on 10/25/20.
//

import SwiftUI

struct WorkoutDetailView: View {
    @ObservedObject var workoutStore = WorkoutStore()
    var workout = Workout.mockWorkout
    var workoutResult = WorkoutResult()
    
    @State private var addResultSheet = false
    
    @State var workoutTime = ""
    @State var workoutReps = ""
    
    
    
    var AddResultView : some View {
        VStack{
            Text("Add Result").font(.title2).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.white).padding(50)
            TextField("Enter the time in seconds", text: self.$workoutTime)
                .padding()
            TextField("Enter the reps", text: self.$workoutReps)
                .padding()
            Button(action: self.addNewResult, label: {
                Text("Add Result")
            }).padding()
            Spacer()
        }
    }
    
    var body: some View {
        VStack{
            VStack{
                Text(workout.title)
                    .font(.title)
                    .padding()
                Text(workout.description)
                    .padding(.bottom)
                
                ForEach(workout.workoutMovements, id: \.self) { workoutMovement in
                    VStack(alignment: .leading){
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
                    }
                }
                
            }
            Spacer()
            
            VStack{
                HStack{
                    Text("Results")
                        .font(.title2)
                        .padding()
                    Spacer()
                }
            }.padding().frame(height: 50)
        }
        List{
            
            ForEach(self.workoutStore.workoutResults) { workoutResult in
                VStack(alignment: .leading){
                    Text("Workout Time: \(workoutResult.workoutTime)")
                    Text("Workout Reps: \(workoutResult.workoutReps)")
                }.padding()
                
                
            }.onMove(perform: self.move)
            .onDelete(perform: self.delete)
        }
        Spacer()
        HStack{
            Button(action: {self.addResultSheet.toggle()}, label: {
                Spacer()
                Text("Add Result")
                Spacer()
            }).padding().frame(height: 60).background(Color.pink).foregroundColor(.white)
        }
        .sheet(isPresented: $addResultSheet, content: {AddResultView})
    }
    
    func addNewResult() {
        workoutStore.workoutResults.append(WorkoutResult(id: "", workoutTime: workoutTime, workoutReps: workoutReps))
        self.workoutStore.save()
        print("Item saved")
        self.workoutReps = ""
        self.workoutTime = ""
        self.addResultSheet.toggle()
        
    }
    
    func move(from source: IndexSet, to destination : Int){
        workoutStore.workoutResults.move(fromOffsets: source, toOffset: destination)
        self.workoutStore.save()
    }
    
    func delete(at offsets: IndexSet){
        workoutStore.workoutResults.remove(atOffsets: offsets)
        self.workoutStore.save()
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView()
    }
}
