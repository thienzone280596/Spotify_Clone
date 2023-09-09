//
//  SettingsModels.swift
//  Spotify
//
//  Created by LE BA TRONG on 05/02/2022.
//

import Foundation

struct Section {
    let title:String
    let options:[Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
