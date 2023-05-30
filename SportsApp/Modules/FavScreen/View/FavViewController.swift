//
//  FavViewController.swift
//  SportsApp
//
//  Created by Mac on 30/05/2023.
//

import UIKit
import Reachability

protocol ReloadTableViewDelegate: AnyObject {
    func reloadTableView()
}

class FavViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource, ReloadTableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noFavImg: UIImageView!
    var favCoreData = FavCodeData.sharedDB
    var favList : [LeagueLocal] = Array<LeagueLocal>()
    var viewModel : FavViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = FavViewModel(favCoreData: favCoreData)
        noFavImg.isHidden = true
        
        let  nib = UINib(nibName: "LeaguesCustomView", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.bindResultToViewController = {
            [weak self] in
            DispatchQueue.main.async {
                self?.favList = self?.viewModel.result ?? [LeagueLocal]()
                if (self?.favList.count == 0){
                    self?.noFavImg.isHidden = false
                }else{
                    self?.noFavImg.isHidden = true
                }
                self?.tableView.reloadData()
            }
        }
        viewModel.getItems()
    }
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if favList.count == 0{
            return 0
        }
        return favList.count
    }
    
    func reloadTableView() {
        viewModel.getItems()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesCustomView
        
        cell.leagueName.text = favList[indexPath.row].name
        
        let url = URL(string: favList[indexPath.row].logo)
        
        cell.leagueImage.kf.setImage(
              with: url,
              placeholder: UIImage(named: "league"),
              options: [
                  .scaleFactor(UIScreen.main.scale),
                  .transition(.fade(1)),
                  .cacheOriginalImage
              ])
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        
        cell.leagueImage?.layer.cornerRadius=(cell.leagueImage?.frame.size.width ?? 100)/2
        cell.leagueImage?.clipsToBounds=true
        
        cell.contentView.layer.borderWidth = 2
            cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.cornerRadius = (cell.leagueImage?.frame.size.width ?? 100)/2
        
        // Configure the cell...

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reachability = try! Reachability()
        if reachability.connection != .unavailable{
                let vc = storyboard?.instantiateViewController(withIdentifier: "details") as! DetailsViewController
                vc.currentLeagueLocal = favList[indexPath.row]
            vc.isFav = true
            vc.favTableViewController = self
            vc.sportName = favList[indexPath.row].sport
                self.present(vc, animated: true, completion: nil)
        }
        else{
            let alert : UIAlertController = UIAlertController(title: "ALERT!", message: "No Connection", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
