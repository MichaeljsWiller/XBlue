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
                //List {
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
                            
                            Section(header: Text(service.uuid)
                                        .font(.system(size: 20, design: .rounded))
                                        .foregroundColor(.gray)) {
                                
                            }
                        }
                    }
               /// }
                Spacer()
                Button("Disconnect") {
                    bleManager.disconnect(peripheral: connectedDevice.peripheral)
                }
                .frame(width: 280, height: 50, alignment: .center)
                .cornerRadius(10)
                .background(Color.red)
            }
        }
    }
}
