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
    
    @IBAction func refresh(_ sender: Any) {
        self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            Alamofire.request("http://modlist.mcf.li/api/v3/1.9.json")
            .responseJSON { response in
                switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            for i in 0...json.count {
                                print("JSON: \(json[i]["name"])")
                                let name = String(describing: json[i]["name"])
                                let link = String(describing: json[i]["link"])
                                self.JAYSON.append((name, link))
                            }
                        }
                        self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
                    case .failure(let error):
                        print(error)
                }
            }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("YOTOYY")
        return 1

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("nantu")
        return JAYSON.count
    }
    
    func heartTapped(_ sender: UITapGestureRecognizer) {
        
        let tapLocation = sender.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: tapLocation)
        if indexPath?.row != nil {
            if let index = TableViewController.favorites.index(of: self.JAYSON[indexPath!.row].0) {
                TableViewController.favorites.remove(at: index)
            }else{
                
                TableViewController.favorites.append(self.JAYSON[indexPath!.row].0)
                print("\(self.JAYSON[indexPath!.row].0) at row \(String(describing: indexPath?.row)) just favorited")
            }
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! ModTableViewCell

        let lame = self.JAYSON[indexPath.row]
        // Configure the cell...
        cell.mod.text = lame.0
        print("TOB")
        cell.heart.row = indexPath.row
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(self.heartTapped(_:)))
        cell.heart.isUserInteractionEnabled = true
        cell.heart.addGestureRecognizer(tapGestureRecognizer)
        
        if TableViewController.favorites.contains(lame.0) {
            cell.heart.image = UIImage(named: "filledheart")
        } else {
           cell.heart.image = UIImage(named: "heart")
        }
        
        self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.openURL(NSURL(string: self.JAYSON[indexPath.row].1)! as URL)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    
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


