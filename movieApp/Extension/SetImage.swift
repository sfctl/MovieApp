//
//  SetImage.swift
//  movieApp
//
//  Created by Yasemin YEL on 23.10.2020.
//  Copyright © 2020 Sifa. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    
    func setImage(imageUrl : String){
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
