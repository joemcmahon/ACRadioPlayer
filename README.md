<p align="center">
<img alt="ACRadioPlayer" src="https://pemungkah.com/wp-content/uploads/2024/12/ACRadioPlayer_header.png" width="749">
</p>

# ACRadioPlayer

[![CI Status](https://github.com/joemcmahon/ACRadioPlayer/workflows/Swift/badge.svg)](https://github.com/joemcmahon/ACRadioPlayer/actions?query=workflow%3ASwift)
[![CI Status](http://img.shields.io/travis/joemcmahon/ACRadioPlayer.svg?style=flat)](https://travis-ci.org/joemcmahon/ACRadioPlayer)
[![Version](https://img.shields.io/cocoapods/v/ACRadioPlayer.svg?style=flat)](http://cocoapods.org/pods/ACRadioPlayer)
[![License](https://img.shields.io/cocoapods/l/ACRadioPlayer.svg?style=flat)](http://cocoapods.org/pods/ACRadioPlayer)
[![Platform](https://img.shields.io/cocoapods/p/ACRadioPlayer.svg?style=flat)](http://cocoapods.org/pods/ACRadioPlayer)

ACRadioPlayer is an extended version of [FRadioPlayer](https://github.com/fethica/FRadioPlayer). It too provides
a wrapper around AVPlayer to handle internet radio playback, but adds support for radio stations hosted on
[Azuracast](https://www.azuracast.com/).

Specifically, it uses Azuracast's websocket SSE high-frequency updates to provide more metadata than FRadioPlayer
could:
 - Artwork comes directly from your Azuracast server, and does not require iTunes or Spotify.
 - Album name is available in addition to the artist and track.
 - Track time and elapsed time provided if available.
 - Track history (album, title, artist, and artwork) are available (if configured on the Azuracast server).

#### Please note that the project is currently still in flux, and some features are still being implemented/altered.

The sample projects are in the process of being updated to use the new library. The current version of the library
is simply a renamed version of FRadioPlayer, tweaked so that the library name is different and all current code works.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

<p align="center">
    <img alt="ACRadioPlayer" src="https://pemungkah.com/wp-content/uploads/2024/12/ACRadioPlayer_demo.png" width="485">
</p>

## Features
- [x] Support internet radio URL playback
- [x] Real-time push updates of metadata
- [x] Update and show album artwork (extracted by Azuracast from track metadata)
- [x] Automatic handling of interruptions
- [x] Automatic handling of route changes
- [x] Support bluetooth playback
- [x] Swift 5
- [x] [Full documentation](https://joemcmahon.github.io/ACRadioPlayer/) (NOTE: still in process; updates required for new APIs)
- [x] Network interruptions handling
- [x] Support for Carthage
- [x] Support for macOS
- [x] Support for tvOS
- [x] Support for Swift Package Manager SPM
- [ ] Support for Audio Taps
- [ ] Support for Audio Recording

## Requirements
- macOS 10.12+
- iOS 13.5+
- tvOS 10.0+
- Xcode 13+
- Swift 5

## Installation

We currently suggest you use Swift Pacjage Manager to install ACRadioPlayer. We are currently working on getting the other
installation options working.

### CocoaPods

ACRadioPlayer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ACRadioPlayer'
```

### Carthage

ACRadioPlayer is available through [Carthage](https://github.com/Carthage/Carthage). To install it, simply add the following line to your Cartfile:

```text
github "joemcmahon/ACRadioPlayer" ~> 0.1.10
```

### Swift Package Manager

ACRadioPlayer is available through [SPM](https://github.com/apple/swift-package-manager). To install it, simply add the following dependency to your `Package.swift` file:

```text
.package(url: "https://github.com/joemcmahon/ACRadioPlayer.git", from: "0.1.18")
```

### Manual

Drag the `Source` folder into your project.

## Usage

### Basics

1. Import `ACRadioPlayer` (if you are using Cocoapods)

```swift
import ACRadioPlayer
```

2. Get the singleton `ACRadioPlayer` instance

```swift
let player = ACRadioPlayer.shared
```

3. Set the delegate for the player

```swift
player.delegate = self
```

4. Set the radio URL
```swift
player.radioURL = URL(string: "http://example.com/station.mp3")
```

### Properties

- `isAutoPlay: Bool` The player starts playing when the `radioURL` property gets set. (default == `true`)

- `rate: Float?` Read only property to get the current `AVPlayer` rate.

- `isPlaying: Bool` Read only property to check if the player is playing.

- `state: ACRadioPlayerState` Player current state of type `ACRadioPlayerState`.

- `playbackState: ACRadioPlaybackState` Playing state of type `ACRadioPlaybackState`.

### Playback controls

- Play
```swift
player.play()
```

- Pause
```swift
player.pause()
```

- Stop
```swift
player.stop()
```

- Toggle playing state
```swift
player.togglePlaying()
```

### Delegate methods

Called when player changes state
```swift
func radioPlayer(_ player: ACRadioPlayer, playerStateDidChange state: ACRadioPlayerState)
```

Called when the playback changes state
```swift
func radioPlayer(_ player: ACRadioPlayer, playbackStateDidChange state: ACRadioPlaybackState)
```

Called when player changes the current player item
```swift
func radioPlayer(_ player: ACRadioPlayer, itemDidChange url: URL?)
```

Called when player item changes the timed metadata value
```swift
func radioPlayer(_ player: ACRadioPlayer, metadataDidChange artistName: String?, trackName: String?)
```
Note: this API is currently being updated to handle the more complex metadata available from Azuracast.

## Apps using this library

For more complete app features, check out [RadioSpiral](https://github.com/joemcmahon/RadioSpiral) based on **ACRadioPlayer**.
Currently under development; will be updated to use more Azuracast features as ACRadioPlayer makes them available.

<p align="center">
    <img alt="RadioSpiral demo screens" src="https://pemungkah.com.com/radiospiral_demo.jpg">
</p>

## Hacking

The Xcode project is generated automatically from `project.yml` using [XcodeGen](https://github.com/yonaskolb/XcodeGen). It's only checked in because Carthage needs it, do not edit it manually.

```sh
$ mint run yonaskolb/xcodegen
💾  Saved project to ACRadioPlayer.xcodeproj
```

## Author

[Joe McMahon](https://pemungkah.com), based on work by [Fethi El Hassasna](https://twitter.com/fethica)

## License

ACRadioPlayer is available under the MIT license. See the LICENSE file for more info.
