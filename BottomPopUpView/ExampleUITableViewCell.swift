//
//  ExampleUITableViewCell.swift
//  BottomPopUpViewExamples
//
//  Created by Akbar on 6/9/20.
//  Copyright © 2020 Akbar. All rights reserved.
//

import UIKit

class ExampleUITableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
