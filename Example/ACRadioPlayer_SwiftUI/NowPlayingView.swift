//
//  NowPlayingView.swift
//  ACRadioPlayer_SwiftUI
//
//  Created by Urayoan Miranda on 12/4/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import ACRadioPlayer
import ACWebSocketClient
import Kingfisher

struct NowPlayingView: View {
    
    @EnvironmentObject var radioPlayer: RadioPlayer
    @EnvironmentObject var client: ACWebSocketClient
    
    var body: some View {
        HStack {
            KFImage(client.status.artwork)
                .resizable()
                .foregroundColor(Color.secondary)
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text(client.status.track)
                    .font(.body)
                    .bold()
                    .lineLimit(1)
                    .allowsTightening(true)
                    
                Text(client.status.artist)
                    .font(.footnote)
                    .lineLimit(1)
                    .allowsTightening(true)
            })
                        
            Spacer()
            
            AirPlayView()
                .frame(width: 50, height: 50)
        }
        .padding(.all, 8)
        .background(Color(UIColor.secondarySystemBackground))
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        let state = RadioPlayer()
        let client = ACWebSocketClient()

        NowPlayingView()
            .environmentObject(state)
            .environmentObject(client)
            .preferredColorScheme(.dark)
    }
}

