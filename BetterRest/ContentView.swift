//
//  ContentView.swift
//  BetterRest
//
//  Created by Daniel Pape on 15/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = Date()
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var body: some View {
        NavigationView{
            VStack{
                Text("When would you like to wake up?")
                    .font(.headline)
                DatePicker("Pick a date",
                           selection: $wakeUp,
                           displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                Text("Desired amount of sleep")
                    .font(.headline)

                Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
                    Text("\(sleepAmount,specifier: "%g") hours")
                }.padding()
                
                Text("Amount of Coffee")
                    .font(.headline)

                Stepper(value: $coffeeAmount, in: 1...20, step: 1){
                    Text("\(coffeeAmount) cup\(coffeeAmount == 1 ? "" : "s")")
                }.padding()
            }
            .navigationTitle("Better Rest")
            .navigationBarItems(trailing:
                                    Button(action:calculateBedTime){
                    Text("Calculate")
                }
            )
        }
    }
    
    func calculateBedTime(){
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
