//
//  File.swift
//  movieApp
//
//  Created by Yasemin YEL on 22.10.2020.
//  Copyright © 2020 Sifa. All rights reserved.
//

import Foundation


struct NowPlaying : Codable {
    
    let title : String
    let id : Int
    let poster_path : String
    let release_date : String
    
    
}

struct NowPlayingResponse : Codable {
    
    let results : [NowPlaying]
    
}
