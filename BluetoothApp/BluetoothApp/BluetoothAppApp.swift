//
//  BluetoothAppApp.swift
//  BluetoothApp
//
//  Created by Michael Willer on 11/02/2021.
//

import SwiftUI

@main
struct BluetoothAppApp: App {
    @ObservedObject var bleManger = BLEManager()
    var body: some Scene {
        
        WindowGroup {
            NavigationView {
                ContentView()
                    .navigationBarTitle("XBlue", displayMode: .inline)
            }
            .environmentObject(bleManger)
        }
    }
}
