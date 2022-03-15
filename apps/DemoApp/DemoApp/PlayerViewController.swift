//
//  PlayerViewController.swift
//  DemoApp
//
//  Created by Stephanie Zuñiga on 14/3/22.
//  Copyright © 2022 Mux, Inc. All rights reserved.
//

import UIKit
import MUXSDKBitmovin
import MuxCore
import BitmovinPlayer

class PlayerViewController: UIViewController {
    let videoURL = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
    var playerView: PlayerView?
    
    // MUX
    let playerName = "iOS BitmovinPlayer"
    let environmentKey = "YOUR_ENV_KEY_HERE"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        self.setupBitmovinPlayer()
        self.setupMux()
    }
    
    private func setupBitmovinPlayer() {
        // Define needed resources
        guard let streamUrl = URL(string: self.videoURL) else {
            return
        }

        // Create player configuration
        let playerConfig = PlayerConfig()
        
        // Enable auto play for tvOS
        playerConfig.playbackConfig.isAutoplayEnabled = true

        // Create player based on player config
        let player = PlayerFactory.create(playerConfig: playerConfig)
        
        // Create player view and pass the player instance to it
        let playerView = PlayerView(player: player, frame: .zero)
        self.playerView = playerView
        
        playerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        playerView.frame = view.bounds

        view.addSubview(playerView)
        view.bringSubviewToFront(playerView)

        // Create source config
        let sourceConfig = SourceConfig(url: streamUrl, type: .hls)
        player.load(sourceConfig: sourceConfig)
    }
    
    private func setupMux() {
        let playerData = MUXSDKCustomerPlayerData(environmentKey: self.environmentKey)
        playerData?.playerName = self.playerName
        
        let videoData = MUXSDKCustomerVideoData()
        videoData.videoTitle = "Title Video Bitmovin"
        videoData.videoId = "sintel"
        
        let viewData = MUXSDKCustomerViewData()
        viewData.viewSessionId = "my session id"
        
        let customData = MUXSDKCustomData()
        customData.customData1 = "Bitmovin test"
        customData.customData2 = "Custom Data 2"
        
        let viewerData = MUXSDKCustomerViewerData()
        viewerData.viewerApplicationName = "MUX Bitmovin DemoApp"
        
        let customerData = MUXSDKCustomerData(
            customerPlayerData: playerData,
            videoData: videoData,
            viewData: viewData,
            customData: customData,
            viewerData: viewerData
        )
        
        guard let playerView = self.playerView, let data = customerData else {
            return
        }
        
        MUXSDKStats.monitorPlayer(
            player: playerView,
            playerName: self.playerName,
            customerData: data
        )
    }
    
    deinit {
        self.playerView?.player?.destroy()
    }
}

