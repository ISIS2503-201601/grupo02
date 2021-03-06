//
//  EventosTableViewController.swift
//  SATT Mobile
//
//  Created by Daniel Soto rey on 17/05/16.
//  Copyright © 2016 Daniel Soto Rey. All rights reserved.
//

import UIKit
import Gloss
import MBProgressHUD

class EventosTableViewController: UITableViewController, SATTController {
    
    var eventos : [Evento] = []
    var unauthorized = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        loadContent()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return unauthorized ? 1:eventos.count
    }

    func loadContent(){
        
        MBProgressHUD.showHUDAddedTo(self.view!, animated: true).labelText = "Descargando eventos..."
        
        unauthorized = SATT.infoManager.getEventosWithBlock({(results:[Evento]?, error:ErrorType?) in
            
            dispatch_async(dispatch_get_main_queue(),{
                
                if (error != nil){
                    //Error
                }
                else{
                    self.eventos = results!
                }
                
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                self.tableView.reloadData()
            })
            
            
        })
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (unauthorized){
            let cell = tableView.dequeueReusableCellWithIdentifier("evento", forIndexPath: indexPath)
            cell.textLabel?.text = "No tienes permisos para ver los eventos"
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("evento", forIndexPath: indexPath)
        
        let evento = eventos[indexPath.row]
        
        cell.textLabel?.text = "Lat: \(evento.lat) | Lng: \(evento.lng) - Dist: \(evento.distancia)"
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
