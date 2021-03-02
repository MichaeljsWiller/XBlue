//
//  BLEManager.swift
//  BluetoothApp
//
//  Created by Michael Willer on 11/02/2021.
//

import Foundation
import CoreBluetooth

class BLEManager: NSObject, ObservableObject {
    /// Whether the bluetooth is on or off
    @Published var isSwitchOn: Bool = false
    @Published var peripherals = [Peripheral]()
    @Published var connectedDevice: Peripheral? = nil
    private var centralManager: CBCentralManager!
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        centralManager.delegate = self
    }

    /// Starts scanning for ble devices
    func startScan() {
        centralManager.scanForPeripherals(withServices: nil)
        print("scan strated")
    }
    
    /// connects to the selected device
    func connect(peripheral: CBPeripheral) {
        if peripheral.state != .connected {
            centralManager.connect(peripheral)
            if peripheral.state == .connecting {
                print("connecting to \(peripheral)")
            }
        }
    }
    
    /// disconnects from the selected device
    func disconnect(peripheral: CBPeripheral) {
        centralManager.cancelPeripheralConnection(peripheral)
        print("disconnecting from \(peripheral)")
    }
    
    /// Stops the scan for devices
    func stopScan() {
        centralManager.stopScan()
        print("Scan stopped")
    }
    
    /// Clears the list of discovered devices and stops further scanning for devcies
    func reset() {
        stopScan()
        peripherals = []
        print("Peripheral list has been reset")
    }
}


// MARK: - Central Manager delegate methods
extension BLEManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if centralManager.state == .poweredOn {
            isSwitchOn = true
        } else {
            isSwitchOn = false
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        peripheral.delegate = self
        let peripheralName = peripheral.name ?? "Unknown"
        
        let check = peripherals.contains { value in
            if peripheral.identifier.uuidString == value.peripheral.identifier.uuidString {
                return true
            } else {
                return false
            }
        }
        
        if !check {
            // get advert data
            var advertData: [AdvertData] = []
            // loop through advertisement data and append keys and value to list
            for (key, values) in advertisementData {
                let value = String(describing: values)
                let newAdvertData = AdvertData(name: key, value: value)
                advertData.append(newAdvertData)
                print("key: \(key), value \(value)")
            }
            // Create new peripheral
            let newPeripheral = Peripheral(
                name: peripheralName,
                rssi: RSSI.intValue,
                peripheral: peripheral,
                advertData: advertData)
                    
            peripherals.append(newPeripheral)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
        print("connected to \(peripheral)")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("\(peripheral) has been disconnected")
    }
}


// MARK: - CBPeripheral delegate methods
extension BLEManager: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let device = connectedDevice else { return }
        guard let services = peripheral.services else { return }
        device.getServices()
        for service in services {
            print(service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            print(characteristic)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("failed to connect to \(String(describing: peripheral.name))")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            if let includedServices = service.includedServices {
                for includedService in includedServices {
                    print("service: \(service), includedService: \(includedService)")
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("new value wriiten to \(characteristic)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("Value updated for \(characteristic)")
    }
}
