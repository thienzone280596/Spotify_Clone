//
//  AllCategriesReponse.swift
//  Spotify
//
//  Created by LE BA TRONG on 15/02/2022.
//

import Foundation
struct AllCategoriesReponse: Codable {
    let categories:Categories
}
struct Categories:Codable {
    let items: [Category]
}
struct Category:Codable {
    let icons: [APIImage]
    let name:String
    let id:String
}
