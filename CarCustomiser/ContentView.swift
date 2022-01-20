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
    
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get: {self.exhaustPackage},
            set: {newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5

                }
            }
        )
        
        let tiresPackageBinding = Binding<Bool> (
            get: {self.tiresPackage},
            set: {newValue in
                self.tiresPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                } else {
                    starterCars.cars[selectedCar].handling -= 2

                }
            }
        )
        
        let drivetrainPackageBinding = Binding<Bool> (
            get: {self.drivetrainPackage},
            set: {newValue in
                self.drivetrainPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration += 0.5
                } else {
                    starterCars.cars[selectedCar].acceleration -= 0.5

                }
            }
        )
        
        let fuelPackageBinding = Binding<Bool> (
            get: {self.fuelPackage},
            set: {newValue in
                self.fuelPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 2
                    starterCars.cars[selectedCar].acceleration += 0.1
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 2
                    starterCars.cars[selectedCar].acceleration -= 0.1


                }
            }
        )
        
       
        Form {
            VStack (alignment: .leading, spacing: 20){
                Text("\(starterCars.cars[selectedCar].displayStats())")
                Button("Next Car", action: {
                    selectedCar += 1
                })
            }
            Section {
                Toggle("Exhaust Package", isOn: exhaustPackageBinding)
                Toggle("Tires Package", isOn: tiresPackageBinding)
                Toggle("Drivetrain Package", isOn: drivetrainPackageBinding)
                Toggle("Fuel Package", isOn: fuelPackageBinding)


            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
    }
}
