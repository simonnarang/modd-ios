//
//  TableViewController.swift
//  Modd
//
//  Created by Simon Narang on 5/14/16.
//  Copyright © 2016 Simon Narang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {

    var JAYSON = [(String, String)]()
    static var favorites = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            Alamofire.request(.GET, "http://modlist.mcf.li/api/v3/1.8.json")
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        print("JSON: \(json)")
                                                }
                        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
                    }
                case .Failure(let error):
                    print(error)
                }

        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return JAYSON.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell

        let lame = self.JAYSON[indexPath.row]
        // Configure the cell...
        cell.mod.text = lame.0
        cell.heart.row = indexPath.row
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(TableViewController.heartTapped(_:)))
        cell.heart.userInteractionEnabled = true
        cell.heart.addGestureRecognizer(tapGestureRecognizer)
        
        if TableViewController.favorites.contains(lame.0) {
            cell.heart.image = UIImage(named: "filledheart")
        } else {
           cell.heart.image = UIImage(named: "heart")
        }
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        UIApplication.sharedApplication().openURL(NSURL(string: self.JAYSON[indexPath.row].1)!)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func heartTapped(img: UITapGestureRecognizer) {
        
        let tapLocation = img.locationInView(self.tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(tapLocation)
        if indexPath?.row != nil {
            if let index = TableViewController.favorites.indexOf(self.JAYSON[indexPath!.row].0) {
                TableViewController.favorites.removeAtIndex(index)
            }else{

                TableViewController.favorites.append(self.JAYSON[indexPath!.row].0)
                print("\(self.JAYSON[indexPath!.row].0) at row \(indexPath?.row) just favorited")
            }
        }
        self.tableView.reloadData()
        
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
