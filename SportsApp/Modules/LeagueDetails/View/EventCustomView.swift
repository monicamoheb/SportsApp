//
//  EventCustomView.swift
//  SportsApp
//
//  Created by Mac on 23/05/2023.
//

import UIKit

class EventCustomView: UICollectionViewCell {

    @IBOutlet weak var teamOneImg: UIImageView!
    @IBOutlet weak var teamTwoImg: UIImageView!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventScoreLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
