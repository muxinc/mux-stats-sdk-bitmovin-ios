//
//MUXSDKStats.swift
//MUXSDKBitmovin
//
//Created by Stephanie Zuñiga on 14/3/22.
//Copyright © 2022 Mux, Inc. All rights reserved.


import Foundation
import BitmovinPlayer
import MuxCore

@objc
public class MUXSDKStats: NSObject {
    private static let MuxPlayerSoftwareBitmovinPlayer = "BitmovinPlayer"
    
    /**
     Starts to monitor a given Bitmovin Player.
     
     Use this method to start a Mux player monitor on the given Bitmovin Player. The player must have a name which is globally unique. The config provided should match the specifications in the Mux docs at https://docs.mux.com
     
     - Parameters:
     - playerView: A Bitmovin PlayerView to monitor
     - playerName: A name for this instance of the player
     - customerData: A MUXSDKCustomerData object with player, video, and view metadata
     - automaticErrorTracking: boolean to indicate if the SDK should automatically track player errors
     - beaconDomain: Domain to send tracking data to, if you want to use a custom beacon domain. Optional.
     */
    @objc
    public static func monitorPlayer(
        player: PlayerView,
        playerName: String,
        customerData: MUXSDKCustomerData,
        automaticErrorTracking: Bool = true,
        beaconDomain: String? = nil
    ) {
        print(">>> Started monitoring playerView: \(playerName)")
    }
}
