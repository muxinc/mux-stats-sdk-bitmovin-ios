//
//  MUXSDKMainDispatcher.swift
//  MUXSDKBitmovin
//
//  Created by Stephanie Zuñiga on 27/4/22.
//  Copyright © 2022 Mux, Inc. All rights reserved.
//

import Foundation
import MuxCore

class MUXSDKMainDispatcher: MUXSDKDispatcher {
    func dispatchGlobalDataEvent(_ event: MUXSDKDataEvent) {
        MUXSDKCore.dispatchGlobalDataEvent(event)
    }
}
