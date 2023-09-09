//
//  Artist.swift
//  Spotify
//
//  Created by LE BA TRONG on 28/01/2022.
//

import Foundation
struct Artist:Codable {
    let id:String
    let name:String
    let type:String
    let images:[APIImage]?
    let external_urls:[String:String]
}
