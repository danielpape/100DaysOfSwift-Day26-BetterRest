//
//  ContentView.swift
//  BetterRest
//
//  Created by Daniel Pape on 15/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    VStack(alignment: .leading){
                        Text("When would you like to wake up?")
                            .font(.headline)
                        DatePicker("Pick a date",
                                   selection: $wakeUp,
                                   displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .onChange(of: wakeUp) { newValue in
                                            calculateBedTime()
                                        }
                    }
                    VStack(alignment: .leading){
                        
                        Text("Desired amount of sleep")
                            .font(.headline)
                        
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
                            Text("\(sleepAmount,specifier: "%g") hours")
                        }
                        .onChange(of: sleepAmount) { newValue in
                                        calculateBedTime()
                                    }
                    }
                    VStack(alignment: .leading){
                        
                        Text("Amount of Coffee")
                            .font(.headline)
                        
                        Stepper(value: $coffeeAmount, in: 1...20, step: 1){
                            Text("\(coffeeAmount) cup\(coffeeAmount == 1 ? "" : "s")")
                        }
                        .onChange(of: coffeeAmount) { newValue in
                                        calculateBedTime()
                                    }
                    }
                }
                Section{
                    if(alertTitle != ""){
                        Text(alertTitle)
                        .font(.headline)
                    Text(alertMessage)
                    
                    }
                }
                .onAppear(){
                    calculateBedTime()
                }
            }
            .navigationTitle("Better Rest")
        }
    }
    
    static var defaultWakeTime:Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedTime(){
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do{
            let prediction = try
                model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
        } catch {
            alertTitle = "error"
            alertMessage = "Sorry, there wasa problem calculating your bedtime."
        }
//        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
