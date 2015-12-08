//
//  AuthentificationViewController.swift
//  SoFridge
//
//  Created by Raphael MAURY on 08/12/2015.
//  Copyright © 2015 Raphael MAURY. All rights reserved.
//

import UIKit

class AuthentificationViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var ValueStatut:[Int] = []
    var statut: Int = 1
    var data = Produit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func seConnecter(sender: AnyObject) {
        
        let username = loginTextField.text!
        let password = passwordTextField.text!
        
        //Si les champs sont vides
        if (username.isEmpty || password.isEmpty){
            //Un pop up apparait si aucun il n'y a pas de valeur dans les textField
            let alert = UIAlertController(title: "Données manquantes", message: "Merci de rentrer vos identifiants", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }else{
            let request = NSMutableURLRequest(URL: NSURL(string: "http://raphaelmaury.fr/iot/login.php")!)
            request.HTTPMethod = "POST"
            let postString = "Login=" + loginTextField.text! + "&Password=" + passwordTextField.text!
            
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if error != nil {
                    print("error=\(error)")
                    return
                }
                
                do{
                    if let jsonData = NSString(data:data!, encoding: NSUTF8StringEncoding) {
                        print("Contenu du fichier json \(jsonData)")
                        let jsonDictionary: AnyObject! = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                        if let json = jsonDictionary as? Array<AnyObject> {
                        
                            let produit : AnyObject? = json[0]
                            print(produit)
                            let collection = produit! as! Dictionary<String, AnyObject>
                            //On recupere les données
                            let statut : AnyObject? = collection["Statut"]
                            self.ValueStatut.append(statut as! Int)
                            print (self.ValueStatut[0])
                            self.statut = self.ValueStatut[0]
                        
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if (self.statut == 1){
                            //Un pop up apparait si aucun il n'y a pas de valeur dans les textField
                            let alert = UIAlertController(title: "Identifiant", message: "Vos identifiants sont incorrect", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "Retour", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                    }else{
                            //Un pop up apparait si aucun il n'y a pas de valeur dans les textField
                            let alert = UIAlertController(title: "bon", message: "ok", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "Retour", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                        }

                    })
                }catch{
                    print("Error")
                }
            }
            task.resume()
        }
        
    }
}