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

extension CBCharacteristicProperties {
    func propertyToString() -> String {
        switch self {
        case .authenticatedSignedWrites:
            return "Authenticated Signed Writes"
        case .broadcast:
            return "Broadcast"
        case .extendedProperties:
            return "Extended Properties"
        case .indicate:
            return "Indicate"
        case .indicateEncryptionRequired:
            return "Indicate Encryption Required"
        case .notify:
            return "Notify"
        case .notifyEncryptionRequired:
            return "Notify Encryption Required"
        case .read:
            return "Read"
        case .write:
            return "Write"
        case .writeWithoutResponse:
            return "writeWithoutResponse"
        default:
            return "Unknown Property"
        }
    }
}
