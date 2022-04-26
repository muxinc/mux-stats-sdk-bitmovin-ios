//
//  MUXSDKPlayerBinding.swift
//  MUXSDKBitmovin
//
//  Created by Stephanie Zuñiga on 14/3/22.
//  Copyright © 2022 Mux, Inc. All rights reserved.
//

import Foundation
import BitmovinPlayer

@objc
public class MUXSDKPlayerBinding: NSObject {
    private var name: String?
    private var software: String?
    private var player: PlayerView?
    private var automaticErrorTracking: Bool
    
    init(name: String, software: String, player: PlayerView, automaticErrorTracking: Bool) {
        self.name = name
        self.software = software
        self.player = player
        self.automaticErrorTracking = automaticErrorTracking
    }
    
    func attachPlayer(_ player: PlayerView) {
        if self.player != nil {
            self.detachPlayer()
        }
        
        self.player = player
    }
    
    func detachPlayer() {
        self.player = nil
    }
}
