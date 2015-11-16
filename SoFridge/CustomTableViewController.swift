//
//  CustomTableViewController.swift
//  SoFridge
//
//  Created by Raphael MAURY on 07/11/2015.
//  Copyright © 2015 Raphael MAURY. All rights reserved.
//

import UIKit

class CustomTableViewController: UITableViewController {
    
    var data = Produit()
    var tabnomproduit: [String] = []
    var tabprix: [String] = []
    var tabimage: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Appel de la fonction researchJson
        researchJson()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tabnomproduit.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cellule", forIndexPath: indexPath) as! CustomTableViewCell

        //let entre = data.donnee[indexPath.row]
        //let image = UIImage(named: entre.image)
        
        //cell.titreProduit.text = entre.produit
        //cell.imageProduit.image = image
        
        cell.titreProduit.text = self.tabnomproduit[indexPath.row]
        
        let urlimage = NSURL(string: tabimage[indexPath.row])
        let dataImage = NSData(contentsOfURL: urlimage!)
        cell.imageProduit.image = UIImage(data: dataImage!)

        return cell
    }
    
    //MARK: - REST calls
    // Cette fonction permet d'aller chercher des informations sur un serveur via un fichier Json
    func researchJson() {
        //création d'un tableau qui contiendra les nom des produits
        //Url ou se trouve le fichier Json
        //let postEndpoint: String = "http://raphaelmaury.fr/iot/dbjson.php"
        //Creation d'une session
        let session = NSURLSession.sharedSession()
        
        let url = data.url()
        //let url = NSURL(string: postEndpoint)!
        
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
                            let calorie : AnyObject? = collection["Calorie"]
                            let image : AnyObject? = collection["Image"]
                            
                            //On ajoute dans le tableau
                            self.tabnomproduit.append(nomproduit as! String)
                            self.tabprix.append(prix as! String)
                            self.tabimage.append(image as! String)
                            
                            //Verification via la console
                            print(self.tabnomproduit)
                            print(prix)
                            print(calorie)
                            print(image)
                            
                        }
                    }
                }

                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //On le met dans un label
                    //self.ipLabel.text = tabnomproduit[0]
                    //self.prixLabel.text = tabprix[0]
                    //Affiche l'url en text
                    //self.imageLabel.text = tabimage[0]
                    
                    //On met dans la variable urlimage l'URL en NSURL
                    //let urlimage = NSURL(string: tabimage[0])
                    //On le transforme en NSDATA
                    //let dataImage = NSData(contentsOfURL: urlimage!)
                    //On affiche dans imageView l'image
                    //self.imageView.image = UIImage(data: dataImage!)
                    
                    self.tableView.reloadData()
                })
                
            } catch {
                //Affiche un message d'errreur si il y a un probleme
                print("bad things happened")
            }
        }).resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail"{
            let detail = segue.destinationViewController as! DetailViewController
            if let indexpath = tableView.indexPathForCell(sender as! UITableViewCell){
                let entre = data.donnee[indexpath.row]
                detail.titre = entre.produit
                detail.Stringdescription = entre.description
                let toto = String(entre.prix)
                detail.StringPrix = toto
                detail.StringImage = entre.image
                
            }
        }
    }
    
}
