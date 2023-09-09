//
//  SearchResult.swift
//  Spotify
//
//  Created by LE BA TRONG on 15/02/2022.
//

import Foundation

enum SearchResult {
    case artist(model:Artist)
    case album(model:Album)
    case playlist(model:Playlist)
    case track(model:AudioTrack)
}
    

