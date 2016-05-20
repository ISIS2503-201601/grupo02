//
//  NuevoEventoViewController.swift
//  SATT Mobile
//
//  Created by Daniel Soto rey on 17/05/16.
//  Copyright © 2016 Daniel Soto Rey. All rights reserved.
//

import UIKit

class NuevoEventoViewController: UIViewController, SATTController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadContent(){
        
//        MBProgressHUD.showHUDAddedTo(self.view!, animated: true).labelText = "Descargando alertas..."
//        
//        SATT.infoManager.getAlertasWithBlock({(results:[Alerta]?, error:ErrorType?) in
//            
//            dispatch_async(dispatch_get_main_queue(),{
//                
//                if (error != nil){
//                    if ((error as! SATT.Errors) == SATT.Errors.Unauthorized){
//                        self.unauthorized = true
//                    }
//                }
//                else{
//                    self.alertas = results!
//                }
//                
//                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
//                self.tableView.reloadData()
//            })
//            
//            
//        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
