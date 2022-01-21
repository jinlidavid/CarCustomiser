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
            Form {
                VStack (alignment: .leading, spacing: 20){
                    Text("\(starterCars.cars[selectedCar].displayStats())")
                    Button("Next Car", action: {
                        selectedCar += 1
                        resetDisplay()
                    })
                }
                
                Section {
                    Toggle("Exhaust Package (Cost: 500)", isOn: exhaustPackageBinding)
                        .disabled(!exhaustPackageActivated)
                    Toggle("Tires Package (Cost: 500)", isOn: tiresPackageBinding)
                        .disabled(!tiresPackageActivated)
                    Toggle("Drivetrain Package (Cost: 500)", isOn: drivetrainPackageBinding)
                        .disabled(!drivetrainPackageActivated)
                    Toggle("Fuel Package (Cost: 500)", isOn: fuelPackageBinding)
                        .disabled(!fuelPackageActivated)
                }
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
