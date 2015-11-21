//
//  Data.swift
//  SoFridge
//
//  Created by Raphael MAURY on 07/11/2015.
//  Copyright © 2015 Raphael MAURY. All rights reserved.
//

import Foundation
public class Produit{
    
    ////////////////////////////
    //MARK: Variable du produit
    ////////////////////////////
    
    //création d'un tableau sur chaques variables qui contiendra les caracteristiques des produits
    var tabid: [String] = []
    var tabnomproduit: [String] = []
    var tabdescription: [String] = []
    var tabprix: [String] = []
    var tabcalorie: [String] = []
    var tabimage: [String] = []
    
    ////////////////
    //MARK: Focntion
    ////////////////
    
    //Fonction Url où se trouve le lien du fichier Json
    func url() -> NSURL {
        let s = "http://raphaelmaury.fr/iot/dbjson.php"
        
        return NSURL(string: s)!
    }
}