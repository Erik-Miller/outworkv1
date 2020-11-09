//
//  WorkoutDiscoverView.swift
//  outwork
//
//  Created by Erik Miller on 11/4/20.
//

import SwiftUI

struct WorkoutDiscoverView: View {
    @ObservedObject var workoutStore = WorkoutStore()
    @State var workout = Workout.mockWorkout
    var workoutResult = WorkoutResult()
    
    
//    var totalReps: Int {
//            for workoutReps in workoutStore.workoutResults {
//            let workoutRepsAsInt = Int("\(workoutReps)") ?? 0
//            var repCountArray:[Int] = []
//                repCountArray.append(workoutRepsAsInt)
//            let total = repCountArray.reduce(0, +)
//            return total
//        }
//    }
    
    

    
        var body: some View {
            NavigationView {
                VStack {
                    VStack(alignment: .leading){
                        Text("Popular Workouts")
                            .padding(.leading)
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                            ForEach(0...5, id: \.self) { index in
                                Button(action: {}, label: {
                                        VStack(alignment: .leading){
                                            Text("\(workoutStore.totalReps(workoutReps: workoutResult.workoutResultReps))")
                                                .padding(.bottom, 10)
                                                .font(.title3)
                                            Text("\(workoutStore.totalTime(workoutTime: workout.workoutTime, workoutResultTime: workoutResult.workoutResultTime)) seconds")
                                                .padding(.bottom, 10)
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                            HStack{
                                                Spacer()
                                            Text("Add Workout")
                                                .font(.caption)
                                            }
                                        }.frame(minWidth: 100)
                                        .padding()
                                        .background(Color.primary.opacity(0.2))
                                        .cornerRadius(20)
                                })
                            }.padding(.horizontal, 8)
                            }.padding(EdgeInsets(top: 10, leading: 12, bottom: 20, trailing: 12))
                            
                        }
                    }
                    VStack(alignment: .leading) {
                        HStack{
                            
                            VStack(alignment: .leading){
                                Text("THIS WEEK'S ACTIVITY")
                                    
                                    .font(.caption)
                                
                                HStack {
                                    Text("5.6 Hours")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Label("0.3 hours", systemImage: "arrow.up")
                                        .padding(10)
                                        .font(.caption)
                                        .background(Capsule().fill(Color.pink))
                                        .frame(maxWidth: 150)
                                    
                                }.padding(.top)
                            }.padding()
                            Spacer()
                        }
                        Spacer()
                    }.frame(maxHeight: 100).padding().background(Color.gray)
                    
                    Spacer()
                    
                    
                }.padding(.top).navigationTitle("Discover")
            }
        }
    }


struct WorkoutDiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDiscoverView()
    }
}
