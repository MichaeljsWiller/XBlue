//
//  ContentView.swift
//  BluetoothApp
//
//  Created by Michael Willer on 11/02/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var bleManager: BLEManager
    
    var body: some View {
        if bleManager.isSwitchOn {
            BluetoothOnView()
        } else {
            BluetoothOffView()
        }
        
    }
}



struct BluetoothOnView: View {
    
    @EnvironmentObject private var bleManager: BLEManager
    @State private var isScanning = false
    
    var body: some View {
        VStack (spacing: 10) {
            List {
                Section(header: Text("Peripherals Nearby")) {
                    ForEach(bleManager.peripherals) { peripheral in
                        HStack {
                            Text(String(peripheral.rssi))
                            Button(peripheral.name) {
                                bleManager.connect(peripheral: peripheral.peripheral)
                                bleManager.connectedDevice = peripheral
                            }
                            Spacer()
                            NavigationLink(destination: DeviceInfoView()) {
                                Text("")
                            }
                            .frame(width: 10)
                            .padding(.trailing)
                        }
                    }
                }
                .padding(.top)
            }
            .padding(.bottom)
            
            HStack {
                Spacer()
                VStack (spacing: 10) {
                    
                    if !isScanning {
                        Button("Start Scanning") {
                            bleManager.startScan()
                            isScanning = true
                        }
                        .frame(width: 280, height: 50, alignment: .center)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    } else {
                        Button("Stop Scanning") {
                            bleManager.stopScan()
                            isScanning = false
                        }
                        .frame(width: 280, height: 50, alignment: .center)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    Button("Clear list") {
                        bleManager.reset()
                    }
                    .frame(width: 280, height: 50, alignment: .center)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }.padding()
 
                Spacer()
            }
            Spacer()
        }
    }
}

struct BluetoothOffView: View {
    var body: some View {
        Text("Bluetooth is NOT switched on")
            .foregroundColor(.red)
    }
}
