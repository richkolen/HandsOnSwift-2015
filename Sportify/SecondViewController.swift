//
//  SecondViewController.swift
//  Sportify
//
//  Created by Richard Kolen on 18-06-15.
//  Copyright (c) 2015 Richard Kolen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var newTraining: UITextField!
    @IBOutlet weak var newExcercise: UITextField!
    
    var excersises:NSMutableArray?
    var trainingList:NSMutableDictionary?
    var descriptions:NSMutableArray?
    var path:String?
    
    var mainExcercise = ["Schouders", "Buikspieren", "Conditie", "Biceps", "Triceps",  "Bovenbenen", "Onderbenen", "Onderrug", "Bovenrug", "Borst"]
    
    var excersiseAction = ["3x8 10kg", "3x8 20kg", "3x8 30kg", "3x8 40kg", "3x8 50kg", "3x8 60kg", "3x8 70kg", "3x8 80kg", "3x8 90kg", "3x8 100kg", "3x8 110kg", "3x8 120kg"]
    
    var excersiseCondition = ["Fietsen", "Hardlopen", "Roeien", "Klimmen", "Opdrukken", "Sprinten"]
    
    var excersiseCount = ["5 keer", "10 keer", "15 keer", "20 keer", "25 keer", "30 keer", "35 keer", "40 keer", "45 keer", "50 keer", "55 keer", "60 keer", "65 keer", "70 keer", "75 keer", "80 keer"]
    
    var selectionArray: [String] = []
    var mainTraining: String = ""
    var trainingExcercise: String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mainTraining = mainExcercise[0]
        trainingExcercise = excersiseAction[0]
        selectionArray = excersiseAction
        
        path = NSBundle.mainBundle().pathForResource("TrainingFile", ofType:"plist")
        trainingList = NSMutableDictionary(contentsOfFile: path!)
        excersises = (trainingList!.objectForKey("Training") as! NSMutableArray)
        descriptions = (trainingList!.objectForKey("Description") as! NSMutableArray)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if(component==0)
        {
            return mainExcercise.count
        }
        else
        {
            return selectionArray.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        if(component==0)
        {
            return mainExcercise[row]
        }
        else
        {
            return selectionArray[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(component==0)
        {
            var selectedString = mainExcercise[row]
            mainTraining = mainExcercise[row]
            
            if(selectedString == "Buikspieren")
            {
                selectionArray = excersiseCount
            }
            else if(selectedString == "Conditie")
            {
                selectionArray = excersiseCondition
            }
            else
            {
                selectionArray = excersiseAction
            }
            
            picker.reloadComponent(1)
        }
        trainingExcercise = selectionArray[row]
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func AddGroup(sender: AnyObject)
    {
        
        if (newTraining.text == "" && newExcercise.text == "")
        {
            excersises!.addObject(mainTraining)
            descriptions!.addObject(trainingExcercise)
            
            sendData()
        }
        else if (newTraining.text != "" && newExcercise.text == "")
        {
            var message = "U bent de beschrijving vergeten!"
            
            let alert:UIAlertView = UIAlertView(title: "Oeps", message: message, delegate: nil, cancelButtonTitle: "OK")
            
            alert.show()
        }
        else if (newExcercise.text != "" && newTraining.text == "")
        {
            var message = "U bent de training vergeten!"
            
            let alert:UIAlertView = UIAlertView(title: "Oeps", message: message, delegate: nil, cancelButtonTitle: "OK")
            
            alert.show()
        }
        else
        {
            excersises!.addObject(newTraining.text)
            descriptions!.addObject(newExcercise.text)
            
            sendData()
            
            newTraining.text = ""
            newExcercise.text = ""
        }
        
    }
    
    func sendData()
    {
        trainingList?.writeToFile(path!, atomically: true)
        self.view.endEditing(true)
        self.tabBarController?.selectedIndex = 0
        
        var message = "Uw training is toegevoegd aan de lijst"
        
        let alert:UIAlertView = UIAlertView(title: "Geslaagd!", message: message, delegate: nil, cancelButtonTitle: "OK")
        
        alert.show()
    }

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        self.view.endEditing(true)
    }
    
}

