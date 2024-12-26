//
//  ViewController.swift
//  ACRadioPlayer_tvOS
//
//  Created by Stefan Brighiu on 11/30/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Foundation
import MediaPlayer
import ACRadioPlayer

class ViewController: UIViewController {

    let player: ACRadioPlayer = ACRadioPlayer.shared

    // List of stations
    let station = Station(name: "RadioSpiral",
                          detail: "Captivating Electronica, 24/7",
                          url: URL(string: "http://spiral.radio:8000/stream.mp3")!
    )

    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!

    // Actions
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        presses.forEach { press in
            switch press.type {
            case .select, .playPause:
                togglePlaying()
            default: break
            }
        }

    }

    func togglePlaying() {
        player.togglePlaying()
    }

    // View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the delegate for the radio player
        player.delegate = self

        stationLabel.text = station.name
        player.radioURL = station.url

        updateNowPlaying(with: track)
        
        // Show current player state
        statusLabel.text = player.state.description
    }

    func updateNowPlaying(with track: Track?) {

        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()

        if let artist = track?.artist {
            nowPlayingInfo[MPMediaItemPropertyArtist] = artist
        }

        nowPlayingInfo[MPMediaItemPropertyTitle] = track?.name ?? station.name

        if let image = track?.image ?? station.image {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { _ -> UIImage in
                return image
            })
        }

        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }

    // Selected station index
    var track: Track? {
        didSet {
            artistLabel.text = track?.artist ?? "none"
            trackLabel.text = track?.name ?? "none"
            updateNowPlaying(with: track)
        }
    }
}

extension ViewController: ACRadioPlayerDelegate {

    func radioPlayer(_ player: ACRadioPlayer, playerStateDidChange state: ACRadioPlayerState) {
        statusLabel.text = state.description
    }

    func radioPlayer(_ player: ACRadioPlayer, playbackStateDidChange state: ACRadioPlaybackState) {
        statusLabel.text = state.description
    }

    func radioPlayer(_ player: ACRadioPlayer, metadataDidChange artistName: String?, trackName: String?) {
        track = Track(artist: artistName, name: trackName)
    }

    func radioPlayer(_ player: ACRadioPlayer, metadataDidChange rawValue: String?) {
        print("Raw Meta:", rawValue ?? "none")
    }

    func radioPlayer(_ player: ACRadioPlayer, itemDidChange url: URL?) {
        track = nil
    }

    func radioPlayer(_ player: ACRadioPlayer, artworkDidChange artworkURL: URL?) {

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let artworkURL = artworkURL, let data = try? Data(contentsOf: artworkURL) else {
                DispatchQueue.main.async { [weak self] in
                    guard let `self` = self else { return }
                    self.artworkImageView.image = self.station.image
                }
                return
            }

            DispatchQueue.main.async { [weak self] in
                self?.track?.image = UIImage(data: data)
                self?.artworkImageView.image = self?.track?.image
                self?.updateNowPlaying(with: self?.track)
            }
        }
    }
}
