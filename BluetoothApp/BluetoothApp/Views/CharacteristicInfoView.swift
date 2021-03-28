//
//  CharacteristicInfoView.swift
//  BluetoothApp
//
//  Created by Michael Willer on 18/03/2021.
//

import SwiftUI
import CoreBluetooth

struct CharacteristicInfoView: View {
    @EnvironmentObject var bleManager: BLEManager
    @State var characteristic: Characteristic
    let serviceUUID: String
    
    var body: some View {
        List {
            Section(header: Text("0x\(serviceUUID)")
                        .font(.system(size:14, weight: .light, design: .rounded))
                        .foregroundColor(.gray)
                        .padding(.leading, -10)) {}
            Section(header: Text("0x\(characteristic.uuid)")
                        .font(.system(size:28, weight: .light, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.leading, -10)
                        .padding(.top, -20)) {}
            Section(header: Text("UUID: \(characteristic.uuid)")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .padding(.leading, -10)
                        .padding(.top, -20)) {}
            if bleManager.connectedDevice?.peripheral.state == .connecting {
                Section(header: ConnectingView()) {}
            } else {
                Section(header: Text(bleManager.connectedDevice?.peripheral.state.stateToString().lowercased().capitalized ?? "")
                            .font(.system(size:15
                                          , design: .rounded))
                            .foregroundColor(.green)
                            .padding(-10)
                            .padding(.top, -25)) {}
            }
            ReadPropertyView()
        }.padding(.top, 10).listStyle(GroupedListStyle())
        
    }
}

struct ReadPropertyView: View {
    
    @EnvironmentObject private var bleManager: BLEManager
    @State var valuesRead: [String] = ["hello"]
    @State var properties: [String] = ["goodbye"]
    
    var body: some View {
        
        Section(header: Text("READ VALUES")
                    .font(.system(size: 14, design: .rounded))
                    .foregroundColor(.gray)
                    .padding(.bottom)
                    .padding(-5)) {
            Button("Read new value") {
                valuesRead.append("test")
            }.foregroundColor(.blue).font(.system(size: 14))
            ForEach(valuesRead , id: \.self) { value in
                VStack {
                    Text(value)
                }
            }
        }
        Section(header: Text("PROPERTIES")
                    .font(.system(size: 14, design: .rounded))
                    .foregroundColor(.gray)
                    .padding(.bottom)
                    .padding(-5)) {
            ForEach(properties, id: \.self) { property in
                VStack {
                    Text(property)
                }
            }
        }
    }
}

struct WritePropertyView: View {
    
    @EnvironmentObject private var bleManager: BLEManager
    @State var writtenValues: [String] = []
    @State var properties: [String] = []
    let characteristic: CBCharacteristic
    
    var body: some View {
        Section(header: Text("WRITTEN VALUES")
                    .font(.system(size: 14, design: .rounded))
                    .foregroundColor(.gray)
                    .padding(.bottom)
                    .padding(-5)) {
            Button("Write new value") {
                writtenValues.append("test")
            }.foregroundColor(.blue).font(.system(size: 14))
            ForEach(writtenValues, id: \.self) { value in
                VStack {
                    Text(value)
                }
            }
        }
        Section(header: Text("PROPERTIES")
                    .font(.system(size: 14, design: .rounded))
                    .foregroundColor(.gray)
                    .padding(.bottom)
                    .padding(-5)) {
            ForEach(properties, id: \.self) { property in
                VStack {
                    Text(property)
                }
            }
        }
    }
}
