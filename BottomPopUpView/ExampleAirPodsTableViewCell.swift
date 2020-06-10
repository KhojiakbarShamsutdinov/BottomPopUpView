//
//  ExampleAirPodsTableViewCell.swift
//  BottomPopUpViewExamples
//
//  Created by Akbar on 6/9/20.
//  Copyright © 2020 Akbar. All rights reserved.
//

import UIKit

class ExampleAirPodsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        let jeremyGif = UIImage.gifImageWithName("airPods")
        let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: 30, y: 0, width: self.contentView.frame.size.width - 100, height: 300)
        contentView.addSubview(imageView)
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
