//
//  NowPlayingSplitView.swift
//  ACRadioPlayer_SwiftUI
//
//  Created by Urayoan Miranda on 12/6/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import ACWebSocketClient
import Kingfisher

struct NowPlayingSplitView: View {
    
    @EnvironmentObject var radioPlayer: RadioPlayer
    @EnvironmentObject var client: ACWebSocketClient

    var body: some View {
        VStack(spacing: 16) {
            VStack {
                KFImage(client.status.artwork)
                    .foregroundColor(Color.secondary)
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                
            }.padding(.leading, 10)
            
            Text(client.status.track)
                .font(.title)
                .lineLimit(1)
                .allowsTightening(true)
                .padding(.trailing, 0)
            
            
            Text(client.status.artist)
                .font(.title2)
                .lineLimit(1)
                .allowsTightening(true)
                .padding(.trailing, 0)
            
            Spacer()
            
            AirPlayView()
                .frame(width: 50, height: 50)
        }
    }
}

struct NowPlayingViewSplit_Previews: PreviewProvider {
    static var previews: some View {
        let radioPlayer = RadioPlayer()
        let client = ACWebSocketClient()

        NowPlayingSplitView()
            .environmentObject(radioPlayer)
            .environmentObject(client)
            .preferredColorScheme(.dark)
    }
}
