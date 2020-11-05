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
                    VStack{
                        
                    }
                    Spacer()
                    
                    
                }.padding(.top).navigationTitle("Insights")
            }
        }
    }


struct WorkoutDiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDiscoverView()
    }
}
