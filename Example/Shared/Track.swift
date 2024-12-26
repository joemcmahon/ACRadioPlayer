//
//  Track.swift
//  ACRadioPlayerDemo
//
//  Created by Fethi El Hassasna on 2017-12-03.
//  Extended by Joe McMaahon on 2024-12-23.
//  Copyright © 2017 Fethi El Hassasna. All rights reserved.
//  Copyright © 2024 Joe McMahon. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif


struct Track {
    var artist: String?
    var name: String?
    var album: String?
    var dj: String?
    
    #if os(iOS) || os(tvOS)
    var image: UIImage?
    #elseif os(OSX)
    var image: NSImage?
    #endif
    
    #if os(iOS) || os(tvOS)
    init(artist: String? = nil, name: String? = nil, image: UIImage? = nil, album: String? = nil, dj: String? = nil) {
        self.name = name
        self.artist = artist
        self.image = image
        self.album = album
        self.dj = dj
    }
    #elseif os(OSX)
    init(artist: String? = nil, name: String? = nil, image: NSImage? = nil, album: String? = nil, dj: String? = nil) {
        self.name = name
        self.artist = artist
        self.image = image
        self.album = album
        self.dj = dj
    }
    #endif
}
