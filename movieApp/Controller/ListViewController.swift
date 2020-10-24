//
//  ViewController.swift
//  movieApp
//
//  Created by Yasemin YEL on 21.10.2020.
//  Copyright © 2020 Sifa. All rights reserved.
//

import UIKit
import Alamofire
import CenteredCollectionView

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
        var nowPlayingResponse : NowPlayingResponse?
        var upComingResponse : UpComingResponse?
        var chosenItemTV : UpComing?
        var centeredCollectionViewFlowLayout = CenteredCollectionViewFlowLayout()

        override func viewDidLoad() {
            super.viewDidLoad()
            
          
            collectionView.collectionViewLayout = centeredCollectionViewFlowLayout
            collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "SliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "sliderCell")

            
            centeredCollectionViewFlowLayout.itemSize = CGSize(
                width: view.bounds.width,
                height: collectionView.bounds.height)

            centeredCollectionViewFlowLayout.minimumLineSpacing = 20
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
                    
            fetchNowPlaying()
            fetchUpComing()
        }
        
        func fetchNowPlaying() {
            AF.request("https://api.themoviedb.org/3/movie/now_playing?api_key=8e17bf180df27a022e1f448a0d0690d6&language=en-US&page=1").responseDecodable(of: NowPlayingResponse.self) { response in
                debugPrint("Response: \(response)")
                
                self.nowPlayingResponse = response.value
                self.collectionView.reloadData()
                
            }
        }
        
        func fetchUpComing() {
            AF.request("https://api.themoviedb.org/3/movie/upcoming?api_key=8e17bf180df27a022e1f448a0d0690d6&language=en-US&page=1").responseDecodable(of: UpComingResponse.self) { response in
                debugPrint("Response: \(response)")
                
                self.upComingResponse = response.value
                self.tableView.reloadData()
                
            }  
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "toDetailVC" {
                
                let destinationVC = segue.destination as! MovieDetailViewController
                
                destinationVC.selectedItem = chosenItemTV
                
            }
        }
        
    }

    extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return nowPlayingResponse?.results.count ?? 0
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! SliderCollectionViewCell
            
            cell.sliderLabel.text = nowPlayingResponse?.results[indexPath.row].title
            if let sliderPosterPath =  nowPlayingResponse?.results[indexPath.row].poster_path {
                
                let url = "https://image.tmdb.org/t/p/w185/" + sliderPosterPath
                
                cell.sliderImageView.setImage(imageUrl: url)
            }else{
                
                cell.sliderImageView.image = nil
                
            }
            return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

          // check if the currentCenteredPage is not the page that was touched
          let currentCenteredPage = centeredCollectionViewFlowLayout.currentCenteredPage
          if currentCenteredPage != indexPath.row {
            // trigger a scrollToPage(index: animated:)
            centeredCollectionViewFlowLayout.scrollToPage(index: indexPath.row, animated: true)
          }
        }
    }

    extension ViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return upComingResponse?.results.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            
            cell.tableViewHeader.text = upComingResponse?.results[indexPath.row].title
            cell.tableViewDetail.text = upComingResponse?.results[indexPath.row].overview
            cell.tableViewDate.text = upComingResponse?.results[indexPath.row].release_date
            
            if let posterPath =  upComingResponse?.results[indexPath.row].poster_path {
                
                let url = "https://image.tmdb.org/t/p/w185/" + posterPath
                
                cell.tableViewImage.setImage(imageUrl: url)
            }else{
                
                cell.tableViewImage.image = nil
                
            }
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            chosenItemTV = upComingResponse?.results[indexPath.row]
            performSegue(withIdentifier: "toDetailVC", sender: nil)
            
        }
        
        
    }
