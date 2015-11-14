//
//  Data.swift
//  SoFridge
//
//  Created by Raphael MAURY on 07/11/2015.
//  Copyright © 2015 Raphael MAURY. All rights reserved.
//

import Foundation

class Data{
    
    class Entrer {
        let produit: String
        let image: String
        let prix: Double
        let description: String
        init(produit: String,image: String, prix: Double, description: String){
            self.produit = produit
            self.image = image
            self.prix = prix
            self.description = description
        }
    }
    
    let donnee = [
        Entrer(produit: "Beurre",image: "beurre.png", prix: 2.1, description: "Plaquette de beurre de 125g"),
        Entrer(produit: "Creme fraiche",image: "creme.png", prix: 3.2, description: "Creme fraiche 30 % de matière grasse 20cl"),
        Entrer(produit: "Lait",image: "lait.png", prix: 0.83, description: "Lait demi-ecreme, 1L")]
}