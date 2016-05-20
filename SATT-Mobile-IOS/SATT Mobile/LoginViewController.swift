//
//  LoginViewController.swift
//  SATT Mobile
//
//  Created by Daniel Soto rey on 17/05/16.
//  Copyright © 2016 Daniel Soto Rey. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var claveField: UITextField!
    
    @IBOutlet weak var jsonText: UILabel!
    
    var parent: MainTabBarControler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadParent(p: MainTabBarControler){
        self.parent = p
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func login(sender: AnyObject) {
        let mail = mailField.text!
        let clave = claveField.text!
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        self.jsonText.text = "Verificando..."
        
        SATT.sessionManager.logInWithUser(mail, pass: clave, block: {(succes:Bool, error:ErrorType?, result:[String:AnyObject]?) in
            
            dispatch_async(dispatch_get_main_queue(),{
                if (succes){
                    //Loggeado
                    self.jsonText.text = "Resultado: \(result!)"
                    
                    if let usr = Usuario(json: result!){
                        self.jsonText.text = "Parsed: \(usr)"
                        SATT.sessionManager.currentUser = usr
                    }
                    else{
                        
                    }
                    self.dismissViewControllerAnimated(true, completion: {self.parent!.loadController()})
                }else{
                    //No loggeado
                    
                    if (result != nil){
                        self.jsonText.text = "Resultado: \(result)"
                        let alert = UIAlertController(title: "Lo sentimos", message: "No hemos podido iniciar sesión. Verifica tus credenciales.", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: {action in
                            
                        }))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }else if (error != nil){
                        self.jsonText.text = "Error"
                    }else{
                        self.jsonText.text = "Ni idea"
                    }

                }
                
                hud.hide(true)
                
            })
            
        })
    }
}
