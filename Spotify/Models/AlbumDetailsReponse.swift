//
//  AlbumDetailsReponse.swift
//  Spotify
//
//  Created by LE BA TRONG on 10/02/2022.
//

import Foundation

struct AlbumDetailsReponse: Codable{
    let album_type: String
    let artists:[Artist]
    let available_markets:[String]
    let external_urls:[String:String]
    let id:String
    let images:[APIImage]
    let label:String
    let name:String
    let tracks:TracksReponse
}

struct TracksReponse:Codable {
    let items:[AudioTrack]
}
