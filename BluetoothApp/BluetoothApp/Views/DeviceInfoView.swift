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
        VStack(alignment: .leading) {
            if let connectedDevice = bleManager.connectedDevice {
                Text(connectedDevice.name)
                    .font(.system(size:20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.bottom)
                    .padding(.top)
                    .padding(.leading)
                Text("UUID: \(connectedDevice.peripheral.identifier.uuidString)")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .padding(.bottom)
                    .padding(.leading)
                HStack {
                    Text(connectedDevice.peripheral.state.stateToString())
                        .padding(.trailing)
                        .padding(.bottom)
                        .padding(.leading)
                    if connectedDevice.peripheral.state == .connecting {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .padding(.bottom)
                    }
                }
                // List displaying advert data
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Section(header: Text("ADVERTISEMENT DATA")
                                    .font(.system(size: 20, design: .rounded))
                                    .foregroundColor(.gray)
                                    .padding(.leading)) {
                            Spacer()
                            Button("Show") {
                                self.isShowing.toggle()
                            }.foregroundColor(.blue).padding(.trailing)
                        }
                    }
                    if isShowing {
                        List(connectedDevice.advertData) { data in
                            VStack {
                                Text(data.name)
                                Text(data.value)
                            }
                        }
                    }
                    
                    // List of services
                    List(connectedDevice.services) { service in
                        Section(header: Text("UUID: \(service.uuid)")
                                    .font(.system(size: 20, design: .rounded))
                                    .foregroundColor(.gray)) {
                            List(service.characteristics) { characteristic in
                                VStack {
                                    Text("0x\(characteristic.uuid)")
                                    Text("Properties:")
                                }
                            }
                        }
                    }
                }
            }
        }
        if let connectedDevice = bleManager.connectedDevice,
           bleManager.connectedDevice?.peripheral.state == .connected {
            VStack(alignment: .center) {
                Button("Disconnect") {
                    bleManager.disconnect(peripheral: connectedDevice.peripheral)
                }
                .frame(width: 280, height: 50, alignment: .center)
                .background(Color.red)
                .cornerRadius(10)
            }
        }
    }
}
