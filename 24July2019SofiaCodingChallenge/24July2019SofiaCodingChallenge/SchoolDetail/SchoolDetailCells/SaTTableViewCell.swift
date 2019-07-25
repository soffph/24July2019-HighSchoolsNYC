//
//  SaTTableViewCell.swift
//  24July2019SofiaCodingChallenge
//
//  Created by sofia delgado gonzalez on 7/24/19.
//  Copyright © 2019 sofia delgado gonzalez. All rights reserved.
//

import UIKit

class SaTTableViewCell: UITableViewCell {
	@IBOutlet weak var labelMathSat : UILabel!
	@IBOutlet weak var labelReadingSat : UILabel!
	@IBOutlet weak var labelWritingSat : UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
