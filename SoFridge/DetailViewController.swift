//
//  DetailViewController.swift
//  SoFridge
//
//  Created by Raphael MAURY on 07/11/2015.
//  Copyright © 2015 Raphael MAURY. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    ////////////////////////////////
    //MARK: Variable Object library
    ///////////////////////////////

    
    @IBOutlet weak var titreProduit: UILabel!
    @IBOutlet weak var descriptionProduit: UILabel!
    @IBOutlet weak var prixProduit: UILabel!
    @IBOutlet weak var calorieProduit: UILabel!
    @IBOutlet weak var imageProduit: UIImageView!
    
    ////////////////////////////
    //MARK: Variable du produit
    ////////////////////////////
    
    var StringId: String = ""
    var StringPorduit: String = ""
    var StringPrix: String = ""
    var Stringdescription: String = ""
    var StringCalorie: String = ""
    var StringImage: String = ""
    
    var data = Produit()
    
    /////////////////
    //MARK: Focntions
    /////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titreProduit.text = StringPorduit
        descriptionProduit.text = Stringdescription
        prixProduit.text = StringPrix
        calorieProduit.text = StringCalorie
        
        let urlimage = NSURL(string: StringImage)
        let dataImage = NSData(contentsOfURL: urlimage!)
        imageProduit.image = UIImage(data: dataImage!)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "edit"{
            let edit = segue.destinationViewController as! EditViewController
                let entreid = StringId
                let entrenom = StringPorduit
                let entreprix = StringPrix
                let entredescription = Stringdescription
                let entrecalorie = StringCalorie
            
                edit.StringId = entreid
                edit.StringProduit = entrenom
                edit.StringPrix = entreprix
                edit.StringDescription = entredescription
                edit.StringCalorie = entrecalorie
            
        }
    }
}