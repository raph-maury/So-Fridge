//
//  EditViewController.swift
//  SoFridge
//
//  Created by Raphael MAURY on 18/11/2015.
//  Copyright © 2015 Raphael MAURY. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    ////////////////////////////////
    //MARK: Variable Object library
    ///////////////////////////////
    
    
    @IBOutlet weak var editNomProduit: UITextField!
    @IBOutlet weak var editDescription: UITextField!
    @IBOutlet weak var editPrix: UITextField!
    @IBOutlet weak var editCalorie: UITextField!
    


    
    var StringId: String = ""
    var StringProduit: String = ""
    var StringPrix: String = ""
    var StringDescription: String = ""
    var StringCalorie: String = ""
    var StringImage: String = ""
    
    /////////////////
    //MARK: Focntions
    /////////////////
    
    @IBAction func saveProduit(sender: AnyObject) {
        
        //Permet de prendre les nouvelles valeurs des textfieds puis les mettre dans les varables globales
        StringProduit = editNomProduit.text!
        StringDescription = editDescription.text!
        StringPrix = editPrix.text!
        StringCalorie = editCalorie.text!
        
        //Gestion des erreures
        if (StringProduit.isEmpty || StringDescription.isEmpty || StringPrix.isEmpty || StringCalorie.isEmpty) {
        
            let alert = UIAlertController(title: "Erreur", message: "Aucune variable est rentrée", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }else{
            
            PostData()
            //On change de vue grace à l'identifiant "r" que l'on a définis dans notre Storyboard
            //performSegueWithIdentifier("r", sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(StringId)
        editNomProduit.text = StringProduit
        editDescription.text = StringDescription
        editPrix.text = StringPrix
        editCalorie.text = StringCalorie
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func PostData(){
        let request = NSMutableURLRequest(URL: NSURL(string: "http://raphaelmaury.fr/iot/updataproduit.php")!)
        request.HTTPMethod = "POST"
        let postString = "Nom_Produit=" + StringProduit + "&Description=" + StringDescription + "&Prix=" + StringPrix + "&Calorie=" + StringCalorie + "&Id=" + StringId
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
}
