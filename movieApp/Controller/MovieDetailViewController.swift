//
//  MovieDetailViewController.swift
//  movieApp
//
//  Created by Yasemin YEL on 21.10.2020.
//  Copyright © 2020 Sifa. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var bgViewDetail: UIView!
    @IBOutlet weak var detailHeaderLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var detailImageView: UIImageView!
    var selectedItem : UpComing?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       detailLabel.text = selectedItem?.overview
       detailHeaderLabel.text = selectedItem?.title
      
        
        if let detailPosterPath =  selectedItem?.poster_path {
            
            let url = "https://image.tmdb.org/t/p/w185/" + detailPosterPath
            
            detailImageView.setImage(imageUrl: url)
        }else{
            
            detailImageView.image = nil
            
        }
        
      
    }
    


}
