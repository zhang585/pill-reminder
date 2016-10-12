//
//  MedicationLogTableTableViewController.swift
//  Pill-Reminder
//
//  Created by Sandy Zhang on 8/20/16.
//  Copyright © 2016 Sandy Zhang. All rights reserved.
//

import UIKit
import CoreData

class MedicationLogTableTableViewController: UITableViewController {
    
    var totalEntries: Int = 0
    
    @IBOutlet var tblLog: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserMedications")
        print("request size : \(request.fetchBatchSize)");
        request.returnsObjectsAsFaults = false
        
        totalEntries = request.fetchBatchSize
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return totalEntries
    }
    
    
    //this function creates a cell every time it's called by the function above
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Default")
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDel.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserMedications")
        request.returnsObjectsAsFaults = false
        
        let results: NSArray = (try? context.fetch(request)) as NSArray!
        
        print("In cellForRowAtIndexPath")
        
        //get contents and put into cell
        let thisMedication: UserMedications = results[indexPath.row] as! UserMedications
        cell.textLabel?.text = thisMedication.medicationName + " " + thisMedication.type
        cell.detailTextLabel?.text = thisMedication.date
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        //delete object from entity, remove from list
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Default")
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDel.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserMedications")
        request.returnsObjectsAsFaults = false
        
        let results: NSArray = (try? context.fetch(request)) as NSArray!
        
        //Get value that is being deeleted
        let tmpObject: NSManagedObject = results[indexPath.row] as! NSManagedObject
        let delMed = tmpObject.value(forKey: "medicationName") as? String
        print("Deleted Medication: \(delMed)")
        
        
        context.delete(results[indexPath.row] as! NSManagedObject)
        do {
            try context.save()
        } catch _ {
        }
        totalEntries = totalEntries - 1
        tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
        print("Done")
    }
    
}
