//
//  Service.swift
//  BluetoothApp
//
//  Created by Michael Willer on 02/03/2021.
//

import Foundation
import CoreBluetooth

/// A class representing a peripehrals service
class Service: Identifiable {

    /// The service of a peripheral
    let service: CBService
    /// The services uuid
    let uuid: String
    /// A list of the services characteristics
    var characteristics: [Characteristic] = []
    
    init(service: CBService, uuid: String) {
        self.service = service
        self.uuid = uuid
        getCharacteristics()
    }
    
    func getCharacteristics() {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics { 
            let newCharacteristic = Characteristic(characteristc: characteristic,
                                                   uuid: characteristic.uuid.uuidString)
            self.characteristics.append(newCharacteristic)
        }
    }
}

/// A class representing a services characteristics
class Characteristic: Identifiable {
    
    /// The characteristic of a service
    let characteristc: CBCharacteristic
    /// The characteristics uuid
    let uuid: String
    
    init(characteristc: CBCharacteristic, uuid: String) {
        self.characteristc = characteristc
        self.uuid = uuid
    }
}
