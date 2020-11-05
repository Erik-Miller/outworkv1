//
//  outworkApp.swift
//  outwork
//
//  Created by Erik Miller on 10/25/20.
//

import SwiftUI

@main
struct outworkApp: App {
    @State private var selection = 0
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selection){
                WorkoutDiscoverView()
                    .tabItem {
                        VStack {
                            Image(systemName: "bonjour")
                            Text("Discover")
                            
                        }
                    }
                    .tag(1)
                
                WorkoutListView()
                    .tabItem {
                        VStack {
                            Image(systemName: "bolt")
                            Text("Workouts")
                        }
                    }
                    .tag(0)
                
                
            }
            .accentColor(Color.pink)
        }
    }
}
