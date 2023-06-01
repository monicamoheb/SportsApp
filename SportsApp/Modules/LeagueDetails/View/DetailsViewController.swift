//
//  DetailsViewController.swift
//  SportsApp
//
//  Created by Mac on 23/05/2023.
//

import UIKit

class DetailsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var favBtn: UIBarButtonItem!
    
    var upComingEventList : [Event] = []
    var latestResultList : [Event] = []
    var teamsList : [Team] = []
    
    var favTableViewController : ReloadTableViewDelegate?
    
    var sportName : String?
    var viewModel : DetailsViewModel!
    var favCoreData = FavCodeData.sharedDB
    var isFav : Bool = false
    var currentLeague : Result!
    var currentLeagueLocal : LeagueLocal!
    var sectionsNames = ["UpComing Events","Latest Results","Teams"]
    var img = UIImage(systemName: "heart")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        var  nib = UINib(nibName: "EventCustomView", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "event")
        
        nib = UINib(nibName: "TeamCustomView", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "team")
        
        
        self.collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader ")
        
        let layout = UICollectionViewCompositionalLayout{ index, environment in
            if(index == 0){
                return self.drawTheTopSection()
            }else if (index == 1){
                return self.drawTheMiddleSection()
            }else{
                return self.drawTheBottomSection()
            }
        }
        
        self.collectionView.setCollectionViewLayout(layout, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        viewModel=DetailsViewModel(favCoreData: favCoreData)
        viewModel.sportName=sportName
        
        if isFav == false {
            if viewModel.ifLeagueIsFav(leagueID: currentLeague.leagueKey ?? 0){
                favBtn.image =  UIImage(systemName: "heart.fill")
                viewModel.leagueID = String(currentLeague.leagueKey ?? 0)
            }
            else{
                favBtn.image =  UIImage(systemName: "heart")
                viewModel.leagueID = String(currentLeague.leagueKey ?? 0)
            }
        }else{
            favBtn.image =  UIImage(systemName: "heart.fill")
            viewModel.leagueID = String(currentLeagueLocal.key)
        }
        
        viewModel.bindResultToViewController={
            [weak self] in
            DispatchQueue.main.async {
                self?.upComingEventList = self?.viewModel.result ?? []
                self?.latestResultList = self?.viewModel.latesEvent ?? []
                self?.collectionView.reloadData()
            }
        }
        viewModel.getItems()
        
    }
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func favBtn(_ sender: Any) {
        
        if favBtn.image == UIImage(systemName: "heart") {
            print("added to fav from leg details vc")
            let img = UIImage(systemName: "heart.fill")
            viewModel.insertLeague(league: LeagueLocal(sport: sportName!, name: currentLeague.leagueName!, logo: currentLeague.leagueLogo ?? "", key: currentLeague.leagueKey!))
            favBtn.image = img
        }else{
            
            let alert : UIAlertController = UIAlertController(title: "ALERT!", message: "ARE YOU SURE TO DELETE?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "YES", style: .default,handler: { [weak self] action in
                let img = UIImage(systemName: "heart")
                self?.favBtn.image = img
                if self?.isFav == false{
                    self?.viewModel.deleteLeague(leagueID: self?.currentLeague.leagueKey ?? 0)
                }else{
                    self?.viewModel.deleteLeague(leagueID: self?.currentLeagueLocal.key ?? 0)
                }
                self?.collectionView.reloadData()
                self?.dismiss(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "NO", style: .cancel,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            print("upcoming \(upComingEventList)")
            return upComingEventList.count
        }else if section == 1{
            print("latest \(latestResultList)")
            return latestResultList.count
        }
        else{
            teamsList = []
            for item in upComingEventList {
                self.teamsList.append(Team(teamLogo: item.awayTeamLogo, teamName: item.eventAwayTeam, teamKey: item.awayTeamKey))
                self.teamsList.append(Team(teamLogo: item.homeTeamLogo, teamName: item.eventHomeTeam, teamKey: item.homeTeamKey))
            }
            for item in latestResultList {
                self.teamsList.append(Team(teamLogo: item.awayTeamLogo, teamName: item.eventAwayTeam, teamKey: item.awayTeamKey))
                self.teamsList.append(Team(teamLogo: item.homeTeamLogo, teamName: item.eventHomeTeam, teamKey: item.homeTeamKey))
            }
            teamsList = Array(Set(teamsList))
            print("teamlist \(teamsList)")
            return teamsList.count
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "event", for: indexPath) as! EventCustomView
            
            var url = URL(string: upComingEventList[indexPath.row].homeTeamLogo ?? "")
            
            cell.teamOneImg.kf.setImage(
                with: url,
                placeholder: UIImage(named: "team1"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            url = URL(string: upComingEventList[indexPath.row].awayTeamLogo ?? "")
            
            cell.teamTwoImg.kf.setImage(
                with: url,
                placeholder: UIImage(named: "team2"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            cell.eventDateLabel.text = upComingEventList[indexPath.row].eventDay
            cell.eventTimeLabel.text = upComingEventList[indexPath.row].eventTime
            cell.eventScoreLabel.text = ""
            cell.teamOneNameLabel.text = upComingEventList[indexPath.row].eventHomeTeam
            cell.teamTwoNameLabel.text = upComingEventList[indexPath.row].eventAwayTeam
            cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
            cell.contentView.layer.borderWidth = 2
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.cornerRadius = 25
            
            return cell
        }
        else if indexPath.section == 1{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "event", for: indexPath) as! EventCustomView
            
            var url = URL(string: latestResultList[indexPath.row].homeTeamLogo ?? "")
            
            cell.teamOneImg.kf.setImage(
                with: url,
                placeholder: UIImage(named: "team1"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            url = URL(string: latestResultList[indexPath.row].awayTeamLogo ?? "")
            
            cell.teamTwoImg.kf.setImage(
                with: url,
                placeholder: UIImage(named: "team2"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            cell.eventScoreLabel.text = latestResultList[indexPath.row].finalResult
            cell.eventDateLabel.text=latestResultList[indexPath.row].eventDay
            cell.eventTimeLabel.text=latestResultList[indexPath.row].eventTime
            cell.teamOneNameLabel.text = latestResultList[indexPath.row].eventHomeTeam
            cell.teamTwoNameLabel.text = latestResultList[indexPath.row].eventAwayTeam
            cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
            cell.contentView.layer.borderWidth = 2
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.cornerRadius = 25
            return cell
        }
        else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "team", for: indexPath) as! TeamCustomView
            cell.teamName.text
            = teamsList[indexPath.row].teamName
            let url = URL(string: teamsList[indexPath.row].teamLogo ?? "")
            
            cell.teamImg.kf.setImage(
                with: url,
                placeholder: UIImage(named: "team"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
            cell.contentView.layer.borderWidth = 2
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.cornerRadius = 25
            return cell
        }
        
    }
    
    func drawTheTopSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(350), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 0)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
        return section
    }
    
    func drawTheMiddleSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(220))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        //  section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0)
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
        return section
    }
    
    func drawTheBottomSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0)
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
            sectionHeader.sectionLabel.text = sectionsNames[indexPath.section]
            
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Click")
        if indexPath.section == 2{
            
            let teamDetails = self.storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController
            
            teamDetails.sportName = sportName
            teamDetails.teamID = String(teamsList[indexPath.row].teamKey ?? 0)
            teamDetails.modalPresentationStyle = .fullScreen
            self.present(teamDetails, animated: true)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        favTableViewController?.reloadTableView()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
