//
//  AdvertData.swift
//  BluetoothApp
//
//  Created by Michael Willer on 02/03/2021.
//

import Foundation
import CoreBluetooth

/// A class representing a peripherals advertisement data
class AdvertData: Identifiable {
    /// The name of the advert data
    let name: String
    /// The value the advert data contains
    let value: String
    
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}
