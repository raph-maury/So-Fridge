//
//  CustomTableViewCell.swift
//  SoFridge
//
//  Created by Raphael MAURY on 07/11/2015.
//  Copyright © 2015 Raphael MAURY. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    ////////////////////////////////
    //MARK: Variable Object library
    ///////////////////////////////
    
    @IBOutlet weak var activityIMD: UIActivityIndicatorView!
    @IBOutlet weak var titreProduit: UILabel!
    @IBOutlet weak var imageProduit: UIImageView!
    
    /////////////////
    //MARK: Focntions
    /////////////////
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
