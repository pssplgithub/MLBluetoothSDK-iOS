//
//  ViewController.swift
//  Example
//
//  Created by Brandon Howard on 3/18/21.
//

import UIKit
import MLBluetooth

class ViewController: UIViewController {
        
    /*
     In order to use this project, please update the following parameters.
     The license will be provided to you by Master Lock.
     The deviceId is written on each Master Lock lock.
     The accessProfile and firmwareVersion for a lock can be
     requested through the Master Lock APIs.
     */
    let license = "YOUR SDK LICENSE"
    let deviceId = "DEVICE ID"
    let accessProfile = "ACCESS PROFILE"
    let firmwareVersion = 12345
    
    /*
     Dictionary of MLProducts - Keep a reference to the MLProducts
     you use and remove them when they are no longer needed.
     This is a map of Device IDs to MLProducts.
     */
    var products = [String : MLProduct]()

    override func viewDidLoad() {
        configureSDK()
    }
    
    func configureSDK() {
        _ = MLBluetoothSDK.main.configure(withLicense: license, delegate: self)
        setupProduct()
    }

    func setupProduct() {
        let product = MLProduct(deviceId: deviceId, accessProfile: accessProfile, firmwareVersion: firmwareVersion)
        product.delegate = self
        products[deviceId] = product
    }
    
    @IBAction func unlockButtonPressed(_ sender: Any) {
        // Get a reference to your MLProduct in the dictionary.
        guard let product = products[deviceId] else { return }
        
        product.unlock(mechanism: .primary) { error in
            if let error = error {
                // An error occurred :(
                print(error)
            } else {
                product.disconnect(withOption: .none) {
                    print("Unlock Successful")
                }
            }
        }
    }
}

extension ViewController: MLLockScannerDelegate {
    
    func didDiscoverDevice(with deviceId: String) {
        /*
         You may wish to make an api call to your server in order
         to check entry rights and retrieve an access profile for a lock.
         If this is the case, ensure that you throttle the request
         because this function is called very frequently.
         */
        print("didDiscoverDevice", deviceId)
     }

    func shouldConnectToDevice(with deviceId: String, andRSSI rssi: NSNumber) -> Bool {
        // Check if you have access to this MLProduct.
        // There may be additional business rules to consider.
        print("shouldConnectToDevice", deviceId)
        return products.keys.contains(deviceId)
    }

    func productFor(deviceId: String) -> MLProduct? {
        // Return the MLProduct for the deviceId from your dictionary.
        print("productForDeviceId", deviceId)
        return products[deviceId]
    }

    func bluetoothModuleDidUpdate(state: MLBluetoothState) {
        // If the state is poweredOn, it is safe to begin scanning.
        if state == .poweredOn {
            _ = MLBluetoothSDK.main.startScanning()
        }
    }
}

extension ViewController: MLProductDelegate {
    
    func product(_ product: MLProduct, didChange state: LockState) {
        
        // BLE visibiltiy
        switch state.visibility {
        case .visible: print("Visible")
        case .unknown: print("Unknown Visibility")
        @unknown default: break
        }
        
        print("Keypad Active: \(state.keypadActive)")
        
        // Primary lock state
        switch state.primary {
        case .unknown: print("Unknown State")
        case .locked: print("Locked")
        case .pendingUnlock: print("Pending Unlock")
        case .unlocked(let countdown):  print("Unlocked: \(countdown)")
        case .open: print("Open")
        case .pendingRelock: print("Pending Relock")
        case .openLocked: print("Open Locked")
        @unknown default: break
        }
        
        // Check state.secondary if applicable, same as above.
    }
    
    func product(_ product: MLProduct, didChangeState state: MLBroadcastState) {}
    
    func didConnect(to product: MLProduct) {
        print("didConnectToProduct", product.deviceId)
    }
    
    func didDisconnect(from product: MLProduct) {
        print("didDisconnectFromProduct", product.deviceId)
    }
    
    func didFailToConnect(to product: MLProduct, error: Error?) {
        print("didFailToConnectToProduct", product.deviceId)
    }
    
    // Used during firmware update. See discussion in documentation.
    func shouldUpdateProductData(product: MLProduct) {}
    
    // See discussion about audit trail in documentation.
    func product(_ product: MLProduct, didRead auditEntries: [MLAuditEntry]) {}
}
