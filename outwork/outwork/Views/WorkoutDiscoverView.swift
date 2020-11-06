//
//  WorkoutDiscoverView.swift
//  outwork
//
//  Created by Erik Miller on 11/4/20.
//

import SwiftUI

struct WorkoutDiscoverView: View {
        var workouts = WorkoutStore()
        
        var body: some View {
            NavigationView {
                VStack {
                    VStack(alignment: .leading){
                        Text("Popular Workouts")
                            .padding(.leading)
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                            ForEach(0...5, id: \.self) { index in
                                VStack{
                                    Text("Workout Name")
                                    HStack{
                                        Spacer()
                                        Button("Add Workout", action: {})
                                        .padding(.top)
                                            .font(.caption)
                                        .foregroundColor(.white)
                                    }
                                }.padding().background(Color.pink).cornerRadius(20)
                                Spacer()
                            }
                            }.padding()
                            
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
