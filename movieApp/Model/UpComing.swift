//
//  UpComing.swift
//  movieApp
//
//  Created by Yasemin YEL on 22.10.2020.
//  Copyright © 2020 Sifa. All rights reserved.
//

import Foundation

struct UpComing : Codable {
    
    let title : String
    let id : Int
    let overview : String
    let release_date : String
    let poster_path : String
    
    
}

struct UpComingResponse : Codable {
    
    let results : [UpComing]
    
}
