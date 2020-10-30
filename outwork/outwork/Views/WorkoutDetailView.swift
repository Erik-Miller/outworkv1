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
        ZStack{
            Color.pink
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                VStack{
                Text(workout.title)
                    .font(.title)
                    .padding()
                Text(workout.description)
                    .padding(.bottom)
                Spacer()
                HStack{
                    Text("Results")
                        .font(.title2)
                        .padding()
                    Spacer()
                    Button(action: {self.addResultSheet.toggle()}, label: {
                        Text("Add Result")
                    })
                }
                }.padding().frame(maxHeight: 150)
                    List{
                    
                    ForEach(self.workoutStore.workoutResults) { workoutResult in
                        VStack(alignment: .leading){
                            Text("Workout Time: \(workoutResult.workoutTime)")
                            Text("Workout Reps: \(workoutResult.workoutReps)")
                        }.padding()
                        
                        
                    }
                }
                
            }
            .sheet(isPresented: $addResultSheet, content: {
                AddResultView
            })
        }
        
    }
    
    func addNewResult() {
        workoutStore.workoutResults.append(WorkoutResult(id: "", workoutTime: workoutTime, workoutReps: workoutReps))
        self.workoutStore.save()
        print("Item saved")
        self.workoutReps = ""
        self.workoutTime = ""
        self.addResultSheet.toggle()
        
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView()
    }
}
