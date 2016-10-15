//
//  EnterYourMedicationViewController.swift
//  Pill-Reminder
//
//  Created by Sandy Zhang on 8/20/16.
//  Copyright © 2016 Sandy Zhang. All rights reserved.
//

import UIKit
import CoreData

class EnterYourMedicationViewController: UIViewController {

    @IBOutlet weak var medicationName: UITextField!
    
    @IBOutlet weak var medicationStrength: UITextField!
    
    @IBOutlet weak var drugType: UISwitch!
    
    @IBAction func logButtonAction(_ sender: AnyObject) {
            if let Name = medicationName.text{
                print("medLoggedButton")
                if Name.isEmpty == false{
                    let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
                    let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
                    let ent = NSEntityDescription.entity(forEntityName: "UserMedications", in: context)!
                    
                    //Instance of our custom class, reference to entity
                    let newMedication = UserMedications(entity: ent, insertInto: context)
                    
                    //Fill in the Core Data
                    newMedication.medicationName = Name
                    if(drugType.isOn){
                        newMedication.type = "Rx"
                    }else{
                        //Switch is off
                        newMedication.type = "OTC"
                    }
                    
                    let dateFormatter = DateFormatter()
                    let curLocale: Locale = Locale.current
                    let formatString: String = DateFormatter.dateFormat(fromTemplate: "EdMMM h:mm a", options: 0, locale: curLocale as Locale)!
                    dateFormatter.dateFormat = formatString as String
                    newMedication.date = dateFormatter.string(from: NSDate() as Date)
                    
                    do {
                        try context.save()
                    } catch _ {
                    }
                }else{
                    //User carelessly pressed save button without entering medication details.
                    let alert:UIAlertController = UIAlertController(title: "No Medication Entered", message: "Enter your medication before pressing save.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(result)in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                print("No element text for the UITextField 'medicationName'")
            }
            
    }
    
    //Hide the keyboard
    func  textFieldShoultReturn(textField: UITextField!) -> Bool {
        medicationName.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
