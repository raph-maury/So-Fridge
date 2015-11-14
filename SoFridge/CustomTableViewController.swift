//
//  CustomTableViewController.swift
//  SoFridge
//
//  Created by Raphael MAURY on 07/11/2015.
//  Copyright © 2015 Raphael MAURY. All rights reserved.
//

import UIKit

class CustomTableViewController: UITableViewController {
    
    let data = Data()

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return data.donnee.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cellule", forIndexPath: indexPath) as! CustomTableViewCell

        let entre = data.donnee[indexPath.row]
        let image = UIImage(named: entre.image)
        
        cell.titreProduit.text = entre.produit
        cell.imageProduit.image = image
        return cell
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
