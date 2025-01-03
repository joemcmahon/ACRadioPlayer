//
//  ACRadioPlayer_SwiftUIApp.swift
//  ACRadioPlayer_SwiftUI
//
//  Created by Urayoan Miranda on 12/3/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import ACRadioPlayer
import ACWebSocketClient
import Kingfisher

@main
struct ACRadioPlayer_SwiftUIApp: App {
    var client = ACWebSocketClient.shared
    var radioPlayer = RadioPlayer()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(radioPlayer)
                .environmentObject(client)
        }
    }
}

struct Radio {
    var track = Track()
    var playerState = ACRadioPlayerState.urlNotSet
    var playbackState = ACRadioPlaybackState.stopped
    var url: URL? = nil
    var rawMetadata: String? = nil
}

class RadioPlayer: ACRadioPlayerDelegate, ObservableObject {
    
    @Published var radio = Radio()
    @Published var client: ACWebSocketClient = ACWebSocketClient.shared
    @Published var currentMetaData: ACStreamStatus = ACStreamStatus()
    
    // Singleton ref to player
    var player: ACRadioPlayer = ACRadioPlayer.shared
    
    // List of stations
    var stations = [Station(name: "AZ Rock Radio",
                            detail: "We Know Music from A to Z",
                            url: URL(string: "http://cassini.shoutca.st:9300/stream")!,
                            image: #imageLiteral(resourceName: "station3")),
                    
                    Station(name: "Metal PR",
                            detail: "El Lechón Atómico",
                            url: URL(string: "http://199.195.194.140:8026/live")!,
                            image: #imageLiteral(resourceName: "station5")),
                    
                    Station(name: "RadioSpiral",
                            detail: "Captivating Electronica 24/7",
                            url: URL(string: "https://spiral.radio:8000/stream.mp3")!,
                            image: #imageLiteral(resourceName: "station6"),
                           serverName: "spiral.radio",
                            shortCode: "radiospiral"),
                    
                    Station(name: "Absolute Country Hits Radio",
                            detail: "The Music Starts Here",
                            url: URL(string: "http:strm112.1.fm/acountry_mobile_mp3")!,
                            image: #imageLiteral(resourceName: "station1"))]
    
    var currentIndex = 0 {
        didSet {
            defer {
                stationDidChange(station: stations[currentIndex])
            }
            
            guard 0 ..< stations.endIndex ~= currentIndex else {
                currentIndex = currentIndex < 0 ? stations.count - 1 : 0
                return
            }
        }
    }
    
    init() {
        player.delegate = self
        player.artworkSize = 500
        player.isAutoPlay = true
    }
    
    func radioPlayer(_ player: ACRadioPlayer, playerStateDidChange state: ACRadioPlayerState) {
        radio.playerState = state
    }
    
    func radioPlayer(_ player: ACRadioPlayer, playbackStateDidChange state: ACRadioPlaybackState) {
        radio.playbackState = state
    }
    
    func radioPlayer(_ player: ACRadioPlayer, metadataDidChange artistName: String?, trackName: String?) {
        guard let artistName = artistName, let trackName = trackName else {
            radio.track.name = stations[currentIndex].name
            radio.track.artist = stations[currentIndex].detail
            return
        }
        
        radio.track.artist = artistName
        radio.track.name = trackName
    }
    
    func radioPlayer(_ player: ACRadioPlayer, itemDidChange url: URL?) {
        radio.url = url
    }
    
    func radioPlayer(_ player: ACRadioPlayer, metadataDidChange rawValue: String?) {
        radio.rawMetadata = rawValue
    }
    
    func radioPlayer(_ player: ACRadioPlayer, artworkDidChange artworkURL: URL?) {
        // Please note that the following example is for demonstration purposes only, consider using asynchronous network calls to set the image from a URL.
        guard let artworkURL = artworkURL, let data = try? Data(contentsOf: artworkURL) else {
            radio.track.image = stations[currentIndex].image
            return
        }
        
        radio.track.image = UIImage(data: data)
    }
    
    // - MARK: Station did Change
    
    private func stationDidChange(station: Station) {
        player.radioURL = station.url
        //radio.track = Track(artist: station.detail, name: station.name, image: station.image)
        if let serverName = station.serverName,
            let shortCode = station.shortCode {
            client.configurationDidChange(serverName: serverName, shortCode: shortCode)
            client.addSubscriber(callback: metadataChanged)
        }
    }
    
    private func metadataChanged(status: ACStreamStatus) {
        if !status.changed {
            return
        }
        print("metadata updated")
        currentMetaData = client.status
    }

}
