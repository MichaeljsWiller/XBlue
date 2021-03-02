//
//  Peripheral.swift
//  BluetoothApp
//
//  Created by Michael Willer on 11/02/2021.
//

import Foundation
import CoreBluetooth

/// A class representing peripherals
class Peripheral: Identifiable {
    
    /// The name of the peripheral
    let name: String
    /// The signal strength for the peripheral
    let rssi: Int
    /// The peripheral object
    let peripheral: CBPeripheral
    /// A list of the peripherals services
    var services: [Service] = []
    /// A list of the peripehrals advertisement data
    var advertData: [AdvertData]
    
    init(name: String, rssi: Int, peripheral: CBPeripheral, advertData: [AdvertData]) {
        self.name = name
        self.rssi = rssi
        self.peripheral = peripheral
        self.advertData = advertData
        getServices()
    }
    
    /// Discovers a list of all the peripherals services
    func getServices() {
        guard let services = peripheral.services else { return }
        for service in services {
            let newService = Service(service: service, uuid: service.uuid.uuidString)
            self.services.append(newService)
        }
    }
}
