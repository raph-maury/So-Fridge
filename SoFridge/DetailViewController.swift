//
//  DetailViewController.swift
//  SoFridge
//
//  Created by Raphael MAURY on 07/11/2015.
//  Copyright © 2015 Raphael MAURY. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var titreproduit: UILabel!
    @IBOutlet weak var descriptionProduit: UILabel!
    @IBOutlet weak var prixProduit: UILabel!
    @IBOutlet weak var imageProduit: UIImageView!
    
    var titre: String = ""
    var Stringdescription: String = ""
    var StringPrix: String = ""
    var StringImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titreproduit.text = titre
        descriptionProduit.text = Stringdescription
        prixProduit.text = StringPrix
        imageProduit.image = UIImage(named: StringImage)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
