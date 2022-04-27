//
//  MUXSDKStats.swift
//  MUXSDKBitmovin
//
//  Created by Stephanie Zuñiga on 14/3/22.
//  Copyright © 2022 Mux, Inc. All rights reserved.
//

import Foundation
import BitmovinPlayer
import MuxCore

@objc
public class MUXSDKStats: NSObject {
    private static let MuxPlayerSoftwareBitmovinPlayer = "BitmovinPlayer"
    private static let bindingsManager = MUXSDKPlayerBindingManager()
    private static var customerViewerData: MUXSDKCustomerViewerData?
    
    private static var deviceIdentifier: String {
        let key = "MUXDeviceId"
        let defaults = UserDefaults.standard
        
        guard let id = defaults.string(forKey: key) else {
            let uuid = UUID().uuidString
            defaults.set(uuid, forKey: key)
            return uuid
        }

        return id
    }
    
    /**
     Starts to monitor a given Bitmovin Player.
     
     Use this method to start a Mux player monitor on the given Bitmovin Player. The player must have a name which is globally unique. The config provided should match the specifications in the Mux docs at https://docs.mux.com
     
     - Parameters:
     - playerView: A Bitmovin PlayerView to monitor
     - playerName: A name for this instance of the player
     - customerData: A MUXSDKCustomerData object with player, video, and view metadata
     - automaticErrorTracking: boolean to indicate if the SDK should automatically track player errors
     */
    @objc
    public static func monitorPlayer(
        player: PlayerView,
        playerName: String,
        customerData: MUXSDKCustomerData,
        automaticErrorTracking: Bool = true,
        beaconCollectionDomain: String? = nil
    ) {
        if let viewerData = customerData.customerViewerData {
            // Data required before initializing the sdk
            customerViewerData = viewerData
        }
        
        self.initSDK()
        
        // Destroy any previously existing player with this name
        if bindingsManager.bindings[playerName] != nil {
            bindingsManager.destroyPlayer(name: playerName)
        }

        if let beacon = beaconCollectionDomain, !beacon.isEmpty {
            MUXSDKCore.setBeaconCollectionDomain(beacon, forPlayer: playerName)
        }

        let newBinding = MUXSDKPlayerBinding(
            name: playerName,
            software: MuxPlayerSoftwareBitmovinPlayer,
            player: player,
            automaticErrorTracking: automaticErrorTracking
        )
        newBinding.attachPlayer(player)

        bindingsManager.bindings[playerName] = newBinding
        bindingsManager.customerDataStore.setData(customerData, forPlayerName: playerName)
        bindingsManager.createNewViewForPlayer(name: playerName)
    }
    
    static func initSDK() {
        // Provide EnvironmentData and ViewerData to Core
    }
}

// MARK: Viewer Data
extension MUXSDKStats {
    private static var viewerApplicationVersion: String? {
        let bundleShortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let bundleVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        guard let shortVersion = bundleShortVersion, let version = bundleVersion else {
            return bundleShortVersion ?? bundleVersion
        }
        
        return "\(shortVersion) (\(version))"
    }
    
    private static var viewerData: MUXSDKViewerData {
        let viewerData = MUXSDKViewerData()
        
        viewerData.viewerApplicationName = customerViewerData?.viewerApplicationName ?? Bundle.main.bundleIdentifier
        viewerData.viewerDeviceManufacturer = "Apple"
        
        if let applicationVersion = viewerApplicationVersion {
            viewerData.viewerApplicationVersion = applicationVersion
        }
        
        if let deviceInfo = UIDevice.current.userInterfaceIdiom.MUXDeviceInfo {
            // If userInterfaceIdiom is not recognized we don't want to send any data
            // Server side device detection should fill in the values
            viewerData.viewerDeviceCategory = deviceInfo.category
            viewerData.viewerOsFamily = deviceInfo.osFamily
        }
        
        viewerData.viewerOsVersion = UIDevice.current.systemVersion
        viewerData.viewerDeviceModel = UIDevice.current.modelCode
         
        return viewerData
    }
}

// MARK: Utilities
private extension UIUserInterfaceIdiom {
    typealias DeviceInfo = (category: String, osFamily: String)
    
    var MUXDeviceInfo: DeviceInfo? {
        switch self {
        case .phone:
            return DeviceInfo(category: "phone", osFamily: "iOS")
        case .pad:
            return DeviceInfo(category: "tablet", osFamily: "iOS")
        case .tv:
            return DeviceInfo(category: "tv", osFamily: "tvOS")
        case .carPlay:
            return DeviceInfo(category: "car", osFamily: "CarPlay")
        case .mac:
            return DeviceInfo(category: "desktop", osFamily: "macOS")
        default:
            return nil
        }
    }
}

private extension UIDevice {
    var modelCode: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}
