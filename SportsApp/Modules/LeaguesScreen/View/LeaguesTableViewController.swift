//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Mac on 21/05/2023.
//

import UIKit
import Kingfisher

class LeaguesTableViewController: UITableViewController {

    var sportName : String?
    var result : [Result] = Array<Result>()
    var viewModel : HomeViewModel!
    var favCoreData = FavCodeData.sharedDB
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let  nib = UINib(nibName: "LeaguesCustomView", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        viewModel = HomeViewModel()
        viewModel.sportName = sportName
        viewModel.bindResultToViewController={
            [weak self] in
            DispatchQueue.main.async {
                self?.result = self?.viewModel.result ?? [Result]()
                self?.tableView.reloadData()
            }
        }
        viewModel.getItems()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return result.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        vc.currentLeague = result[indexPath.row]
        vc.sportName = sportName
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesCustomView
        
        cell.leagueName.text = result[indexPath.row].leagueName
        
        let url = URL(string: result[indexPath.row].leagueLogo ?? "")
        
        cell.leagueImage.kf.setImage(
              with: url,
              placeholder: UIImage(named: "league.png"),
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
        cell.contentView.layer.cornerRadius = 25
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
