//
//  CBPeripheral.swift
//  BluetoothApp
//
//  Created by Michael Willer on 01/03/2021.
//

import Foundation
import CoreBluetooth

extension CBPeripheralState {
    
    /// Converts the peripherals conenection state to string
    func stateToString() -> String {
        switch self {
        case .disconnected:
            return "Disconnected. Data is Stale"
        case .connecting:
            return "Connecting..."
        case .connected:
            return "Connected"
        case .disconnecting:
            return "Disconnecting"
        @unknown default:
            return "Unknown"
        }
    }
}


