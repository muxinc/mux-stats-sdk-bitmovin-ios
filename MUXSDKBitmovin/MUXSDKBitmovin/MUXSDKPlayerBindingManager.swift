//
//  MUXSDKPlayerBindingManager.swift
//  MUXSDKBitmovin
//
//  Created by Stephanie Zuñiga on 21/4/22.
//  Copyright © 2022 Mux, Inc. All rights reserved.
//

import Foundation
import MuxCore

class MUXSDKPlayerBindingManager {
    var bindings: [String: MUXSDKPlayerBinding] = [:]
    let dispatcher: MUXSDKDispatcher
    
    // Customer Data Store
    let customerDataStore = MUXSDKCustomerDataStore()
    
    init(dispatcher: MUXSDKDispatcher) {
        self.dispatcher = dispatcher
    }
    
    func destroyPlayer(name: String) {
        // Remove from bindings dictionary, call viewEnd and detachPlayer
    }
    
    func createNewViewForPlayer(name: String) {
        // Dispatch view init, player ready and initialize binding
    }
}
