//
//  SearchResultReponse.swift
//  Spotify
//
//  Created by LE BA TRONG on 15/02/2022.
//

import Foundation
struct SearchResultsReponse:Codable {
    let albums:SearchAlbumsReponse
    let artists: SearchArtistsResponse
    let playlists: SearchPlaylistsReponse
    let tracks:SearchTracksReponse
}

struct SearchAlbumsReponse:Codable {
    let items: [Album]
}

struct SearchArtistsResponse:Codable {
    let items: [Artist]
}

struct SearchPlaylistsReponse:Codable {
    let items: [Playlist]
}

struct SearchTracksReponse:Codable {
    let items: [AudioTrack]
}
