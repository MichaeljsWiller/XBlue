//
//  DeviceInfoView.swift
//  BluetoothApp
//
//  Created by Michael Willer on 11/02/2021.
//

import SwiftUI

struct DeviceInfoView: View {
    
    @EnvironmentObject var bleManager: BLEManager
    @State var isShowing = false
    
    var body: some View {
        List {
            if let connectedDevice = bleManager.connectedDevice {
                Section(header: Text(connectedDevice.name)
                            .font(.system(size:26, weight: .light, design: .rounded))
                            .foregroundColor(.white)
                            .padding(-10)) {}
                Section(header: Text("UUID: \(connectedDevice.peripheral.identifier.uuidString)")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                            .padding(-10)
                            .padding(.top, -10)) {}
                    if connectedDevice.peripheral.state == .connecting {
                        Section(header: ConnectingView()) {}

                    } else {
                        Section(header: Text(connectedDevice.peripheral.state.stateToString().lowercased().capitalized)
                                    .font(.system(size:14
                                                  , design: .rounded))
                                    .foregroundColor(.green)
                                    .padding(-10)
                                    .padding(.top, -20)) {}
                    }
                // List displaying advert data
                Section(header: AdvertDataSection(showing: $isShowing)) {
                    if isShowing {
                        ForEach(connectedDevice.advertData) { data in
                            VStack(alignment: .leading) {
                                Text(data.value).font(.system(size:18, design: .rounded))
                                Text(data.name).font(.system(size:12, weight: .light))
                            }
                        }
                    }
                }
                // List of services
                ForEach(connectedDevice.services) { service in
                    Section(header: Text("UUID: \(service.uuid)")
                                .font(.system(size: 20, design: .rounded))
                                .foregroundColor(.gray)
                                .padding(.bottom)
                                .padding(-5)) {
                        ForEach(service.characteristics) { characteristic in
                            VStack(alignment: .leading) {
                                Button("0x\(characteristic.uuid)") {
                                    
                                }.font(.system(size:20))
                                Text("Properties:").font(.system(size:14, weight: .light, design: .rounded))
                            }
                        }
                    }
                }
            }
        }.padding(.top, 10).listStyle(GroupedListStyle())
        
        
        if let connectedDevice = bleManager.connectedDevice,
           bleManager.connectedDevice?.peripheral.state == .connected {
            VStack(alignment: .center) {
                Button("Disconnect") {
                    bleManager.disconnect(peripheral: connectedDevice.peripheral)
                }
                .frame(width: 280, height: 50, alignment: .center)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        } else {
            Spacer()
        }
    }
}

struct ConnectingView: View {
    
    @EnvironmentObject var bleManager: BLEManager
    
    var body: some View {
        HStack {
            if let connectedDevice = bleManager.connectedDevice {
                Text(connectedDevice.peripheral.state.stateToString().lowercased().capitalized)
                    .padding(.trailing)
                    .font(.system(size:14, design: .rounded))
                    .foregroundColor(.orange)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .padding(.bottom)
            }
        }.padding(-10).padding(.top, -20)
    }
}

struct AdvertDataSection: View {
    
    @Binding var showing: Bool
    
    var body: some View {
        HStack {
            Section(header: Text("ADVERTISEMENT DATA")
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(.gray)
                        .padding(.bottom)) {
                Spacer()
                Button("Show") {
                    self.showing.toggle()
                }.foregroundColor(.blue).padding(.trailing).padding(.bottom)
            }
        }.padding(-5)
    }
}
