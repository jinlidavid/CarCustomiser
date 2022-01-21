//
//  ContentView.swift
//  CarCustomiser
//
//  Created by David Jin Li on 16/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var starterCars = StarterCars()
    @State private var selectedCar: Int = 0 {
        didSet{
            if selectedCar >= starterCars.cars.count {
                selectedCar = 0
            }
        }
    }
    @State private var exhaustPackage = false
    @State private var tiresPackage = false
    @State private var drivetrainPackage = false
    @State private var fuelPackage = false
    @State private var remainingFunds = 1000
    @State private var remainingTime = 30
    @State private var timerOver = false
    
    var exhaustPackageActivated: Bool {
        return exhaustPackage ? true : remainingFunds >= 500 ? true : false
    }
    
    var tiresPackageActivated: Bool {
        return tiresPackage ? true : remainingFunds >= 500 ? true : false
    }
    
    var drivetrainPackageActivated: Bool {
        return drivetrainPackage ? true : remainingFunds >= 500 ? true : false
    }
    
    var fuelPackageActivated: Bool {
        return fuelPackage ? true : remainingFunds >= 500 ? true : false
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get: {self.exhaustPackage},
            set: {newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                    remainingFunds += 500

                }
            }
        )
        
        let tiresPackageBinding = Binding<Bool> (
            get: {self.tiresPackage},
            set: {newValue in
                self.tiresPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].handling -= 2
                    remainingFunds += 500

                }
            }
        )
        
        let drivetrainPackageBinding = Binding<Bool> (
            get: {self.drivetrainPackage},
            set: {newValue in
                self.drivetrainPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 2.5
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].acceleration += 2.5
                    remainingFunds += 500
                }
            }
        )
        
        let fuelPackageBinding = Binding<Bool> (
            get: {self.fuelPackage},
            set: {newValue in
                self.fuelPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 2
                    starterCars.cars[selectedCar].acceleration -= 0.1
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 2
                    starterCars.cars[selectedCar].acceleration += 0.1
                    remainingFunds += 500
                }
            }
        )
        
        VStack {
            Text("\(remainingTime)")
                .onReceive(timer) {_ in
                    if self.remainingTime > 0 {
                        self.remainingTime -= 1
                    } else {
                        timerOver = true
                    }
                }
                .foregroundColor(.red)
            Form {
                VStack (alignment: .leading, spacing: 20){
                    Text("\(starterCars.cars[selectedCar].displayStats())")
                    Button("Next Car", action: {
                            selectedCar += 1
                            resetDisplay()
                    })
                        .disabled(timerOver)
                }
                
                Section {
                    Toggle("Exhaust Package (Cost: 500)", isOn: exhaustPackageBinding)
                        .disabled(!exhaustPackageActivated || timerOver)
                    Toggle("Tires Package (Cost: 500)", isOn: tiresPackageBinding)
                        .disabled(!tiresPackageActivated || timerOver)
                    Toggle("Drivetrain Package (Cost: 500)", isOn: drivetrainPackageBinding)
                        .disabled(!drivetrainPackageActivated || timerOver)
                    Toggle("Fuel Package (Cost: 500)", isOn: fuelPackageBinding)
                        .disabled(!fuelPackageActivated || timerOver)
                }
                .accessibilityIdentifier(/*@START_MENU_TOKEN@*/"Identifier"/*@END_MENU_TOKEN@*/)
                .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
                .accessibilityValue(/*@START_MENU_TOKEN@*/"Value"/*@END_MENU_TOKEN@*/)
                .accessibilityHint(/*@START_MENU_TOKEN@*/"Hint"/*@END_MENU_TOKEN@*/)
                .accessibilityElement(children: /*@START_MENU_TOKEN@*/.contain/*@END_MENU_TOKEN@*/)
                
            }
            Text("Remaining Funds: \(remainingFunds)")
                .foregroundColor(.red)
        }
    }
    
    func resetDisplay() {
        exhaustPackage = false
        tiresPackage = false
        drivetrainPackage = false
        fuelPackage = false
        remainingFunds = 1000
        starterCars = StarterCars()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
