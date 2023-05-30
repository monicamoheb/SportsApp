//
//  AllSportsCollectionViewController.swift
//  SportsApp
//
//  Created by Mac on 21/05/2023.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

class AllSportsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var sportsList : Array<Sports> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        sportsList = [Sports(name: "Football",img: "football"),
                      Sports(name: "Basketball",img: "basketball"),
                      Sports(name: "Cricket",img: "cricket"),
                      Sports(name: "Tennis",img: "tennis"),]
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sportsList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AllSportsCollectionViewCell
        cell.sportLabel.text = sportsList[indexPath.row].name
    
//        KF.url(URL(string: sportsList[indexPath.row].img!))
//            .placeholder(UIImage(named: "basketball"))
//            .set(to: cell.sportImageView!)
        cell.sportImageView.image = UIImage(named: sportsList[indexPath.row].img ?? "sport")
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        cell.contentView.layer.borderWidth = 2
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.cornerRadius = 25
        
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2-10), height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leagues = storyboard?.instantiateViewController(withIdentifier: "leagues") as! LeaguesTableViewController
        leagues.sportName = sportsList[indexPath.row].name?.lowercased()
        self.navigationController?.pushViewController(leagues, animated: true)
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
