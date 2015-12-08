//
//  CustomTableViewController.swift
//  SoFridge
//
//  Created by Raphael MAURY on 07/11/2015.
//  Copyright © 2015 Raphael MAURY. All rights reserved.
//

import UIKit

class CustomTableViewController: UITableViewController, UISearchResultsUpdating {
    
    // MARK: Variables
    //Appel de la class Produit
    var data = Produit()
    var filtreProduit = [String]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        self.resultSearchController.searchBar.placeholder = "Rechercher"
        self.resultSearchController.searchBar.barTintColor = UIColor.purpleColor()
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        self.tableView.reloadData()
        
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
        if self.resultSearchController.active
        {
            return self.filtreProduit.count
        }
        else{
            return data.tabnomproduit.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cellule", forIndexPath: indexPath) as! CustomTableViewCell

        if  cell.titreProduit.text == nil {
            cell.activityIMD.startAnimating()
            cell.activityIMD.hidden = false
        }else {
            cell.activityIMD.stopAnimating()
            cell.activityIMD.hidden = true
        }
        
        if self.resultSearchController.active{
             cell.titreProduit.text = self.filtreProduit[indexPath.row]
        }else{
            cell.titreProduit.text = data.tabnomproduit[indexPath.row]
            let urlimage = NSURL(string: data.tabimage[indexPath.row])
            let dataImage = NSData(contentsOfURL: urlimage!)
            cell.imageProduit.image = UIImage(data: dataImage!)
        }
        
        
        return cell
    }
    
    
    
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
                if let jsonData = NSString(data:data!, encoding: NSUTF8StringEncoding) {
                    //Affiche dans la console le fichier Json
                    print("Contenu du fichier json \(jsonData)")
                    
                    let jsonDictionary: AnyObject! = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                    if let json = jsonDictionary as? Array<AnyObject> {
                        print(json)
                        //On parcourt le tableau
                        for index in 0...json.count-1 {
                            let produit : AnyObject? = json[index]
                            print(produit)
                            let collection = produit! as! Dictionary<String, AnyObject>
                            //On recupere les données
                            let idproduit : AnyObject? = collection["Id"]
                            let nomproduit : AnyObject? = collection["Nom_Produit"]
                            let prix : AnyObject? = collection["Prix"]
                            let description : AnyObject? = collection["Description"]
                            let calorie : AnyObject? = collection["Calorie"]
                            let image : AnyObject? = collection["Image"]
                            
                            //On ajoute dans le tableau
                            self.data.tabid.append(idproduit as! String)
                            self.data.tabnomproduit.append(nomproduit as! String)
                            self.data.tabprix.append(prix as! String)
                            self.data.tabdescription.append(description as! String)
                            self.data.tabcalorie.append(calorie as! String)
                            self.data.tabimage.append(image as! String)
                            //Verification via la console
                            print(self.data.tabid)
                            print(self.data.tabnomproduit)
                            print(self.data.tabprix)
                            print(self.data.tabdescription)
                            print(self.data.tabimage)
                            
                        }
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
                
            } catch {
                //Affiche un message d'errreur si il y a un probleme
                print("Erreur Json")
            }
        }).resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail"{
            let detail = segue.destinationViewController as! DetailViewController
            if let indexpath = tableView.indexPathForCell(sender as! UITableViewCell){
                let entreid = data.tabid[indexpath.row]
                let entrenom = data.tabnomproduit[indexpath.row]
                let entreprix = data.tabprix[indexpath.row]
                let entredescription = data.tabdescription[indexpath.row]
                let entrecalorie = data.tabcalorie[indexpath.row]
                let entreimage = data.tabimage[indexpath.row]
                
                
                detail.StringId = entreid
                detail.StringPorduit = entrenom
                detail.StringPrix = entreprix
                detail.Stringdescription = entredescription
                detail.StringCalorie = entrecalorie
                detail.StringImage = entreimage
                
            }
        }
    }
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filtreProduit.removeAll(keepCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        let array = (self.data.tabnomproduit as NSArray).filteredArrayUsingPredicate(searchPredicate)
        
        self.filtreProduit = array as! [String]
        
        self.tableView.reloadData()
    }
    
}
