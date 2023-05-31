//
//  ViewController.swift
//  SportsApp
//
//  Created by Mac on 20/05/2023.
//

import UIKit
class TeamDetailsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{

    
    
    @IBOutlet weak var playersCollectionView: UICollectionView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    var teamViewModel : TeamDetailsViewModel!
    var currentTeam : Teams = Teams()
    var playersArray : [Player] = []
    var sportName : String!
    var teamID : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamViewModel = TeamDetailsViewModel()
        teamViewModel.sportName = sportName
        teamViewModel.teamID = teamID
        
        playersCollectionView.dataSource = self
        playersCollectionView.delegate = self
        
        teamViewModel.bindResultToViewController = {
            [weak self] in
            DispatchQueue.main.async {
                self?.currentTeam = self?.teamViewModel.result ?? Teams()
                self?.playersArray = self?.currentTeam.players ?? []
                self?.teamName.text = self?.currentTeam.team_name ?? "No Name"
                let url = URL(string: self?.currentTeam.team_logo ?? "")
                
                self?.teamImg.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "team"))
                
                self?.playersCollectionView.reloadData()
            }
        }
        teamViewModel.getItems()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2-10), height: 200)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TeamPlayerCollectionViewCell
        
        cell.playerName.text = playersArray[indexPath.row].player_name
        let url = URL(string: playersArray[indexPath.row].player_image ?? "")
        
        cell.playerImg.kf.setImage(
            with: url,
            placeholder: UIImage(named: "male.png"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        cell.contentView.layer.borderWidth = 2
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }}


