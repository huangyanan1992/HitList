//
//  HitTableViewController.swift
//  HitList
//
//  Created by 丁丁 on 15/11/29.
//  Copyright © 2015年 huangyanan. All rights reserved.
//

import UIKit
import CoreData

class HitTableViewController: UITableViewController {

    var names = [String]()
    var people = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "姓名列表"
        
    }
    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        do {
            people = try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
        } catch {
            print("\(error)")
        }
        
        
    }

    @IBAction func addNameAction(sender: AnyObject) {
        let alertView = UIAlertController(title: "添加新姓名", message: "请输入一个名字", preferredStyle: UIAlertControllerStyle.Alert)
        let saveAction = UIAlertAction(title: "保存", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            let textField = alertView.textFields![0] as UITextField
            
            self.saveName(textField.text!)
            
            let indexPath = NSIndexPath(forRow: self.people.count-1, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Middle)
            
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
        }
        
        alertView.addAction(saveAction)
        alertView.addAction(cancelAction)
        
        alertView.addTextFieldWithConfigurationHandler { (UITextField) -> Void in
            
        }
        
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    func saveName(name:String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext)
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
    
        person.setValue(name, forKey: "name")
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
        
        people.append(person)
        
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HitCell", forIndexPath: indexPath)
        let person = people[indexPath.row]
        
        cell.textLabel!.text = person.valueForKey("name") as? String

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
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
