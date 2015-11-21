//
//  DataSourceController.swift
//  SoFridge
//
//  Created by Raphael MAURY on 19/11/2015.
//  Copyright © 2015 Raphael MAURY. All rights reserved.
//

import Foundation

class DataSourceController {
    var data = Produit()
    
    //MARK: - REST calls
    // Cette fonction permet d'aller chercher des informations sur un serveur via un fichier Json
    func researchJson() {
        let session = NSURLSession.sharedSession()
        let url = data.url()
        //Appel de POST et le manipuler dans un gestionnaire d'achèvement
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            //Permet de savoir si nous avons eu un bonne reponse du serveur
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            //Lecture du Json
            do {
                if let ipString = NSString(data:data!, encoding: NSUTF8StringEncoding) {
                    //Affiche dans la console le fichier Json
                    print(ipString)
                    
                    let jsonDictionary: AnyObject! = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                    if let json = jsonDictionary as? Array<AnyObject> {
                        print(json)
                        //On parcourt le tableau
                        for index in 0...json.count-1 {
                            let produit : AnyObject? = json[index]
                            print(produit)
                            let collection = produit! as! Dictionary<String, AnyObject>
                            //On recupere les données
                            let nomproduit : AnyObject? = collection["Nom_Produit"]
                            let prix : AnyObject? = collection["Prix"]
                            let description : AnyObject? = collection["Description"]
                            let calorie : AnyObject? = collection["Calorie"]
                            let image : AnyObject? = collection["Image"]
                            
                            //On ajoute dans le tableau
                            self.data.tabnomproduit.append(nomproduit as! String)
                            self.data.tabprix.append(prix as! String)
                            self.data.tabdescription.append(description as! String)
                            self.data.tabcalorie.append(calorie as! String)
                            self.data.tabimage.append(image as! String)
                            //Verification via la console
                            print(self.data.tabnomproduit)
                            print(self.data.tabprix)
                            print(self.data.tabdescription)
                            print(self.data.tabimage)
                        }
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //self.tableView.reloadData()
                })
                
            } catch {
                //Affiche un message d'errreur si il y a un probleme
                print("Erreur Json")
            }
        }).resume()
    }
    
}