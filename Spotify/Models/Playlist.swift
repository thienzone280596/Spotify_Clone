//
//  Playlist.swift
//  Spotify
//
//  Created by LE BA TRONG on 28/01/2022.
//

import Foundation

struct Playlist:Codable {
    let description: String
    let external_urls: [String:String]
    let id: String
    let images: [APIImage]
    let name:String
    let owner:User
}
