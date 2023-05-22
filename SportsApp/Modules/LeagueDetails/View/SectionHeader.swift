//
//  SectionHeader.swift
//  SportsApp
//
//  Created by Mac on 22/05/2023.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    @IBOutlet weak var sectionLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sectionLabel.frame = bounds
    }
}
