//
//  FirstViewController.swift
//  Sportify
//
//  Created by Richard Kolen on 18-06-15.
//  Copyright (c) 2015 Richard Kolen. All rights reserved.
//

import UIKit



class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblTasks: UITableView!
    
    var trainingList:NSMutableDictionary?
    var excersises:NSMutableArray?
    var descriptions:NSMutableArray?
    var path:String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        path = NSBundle.mainBundle().pathForResource("TrainingFile", ofType:"plist")
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()}
    
    override func viewWillAppear(animated: Bool)
    {
        loadData()
        
        tblTasks.reloadData()
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return excersises!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
       let cell = tableView.dequeueReusableCellWithIdentifier("TrainingCell") as! UITableViewCell
        
        cell.textLabel?.text = (excersises![indexPath.row] as! String)
        cell.detailTextLabel?.text = (descriptions![indexPath.row] as! String)
                
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            if editingStyle == .Delete
            {
                excersises?.removeObjectAtIndex(indexPath.row)
                tblTasks.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        }
    }
    
    func loadData()
    {
        trainingList = NSMutableDictionary(contentsOfFile: path!)
        excersises = (trainingList?.objectForKey("Training") as! NSMutableArray)
        descriptions = (trainingList?.objectForKey("Description") as! NSMutableArray)
    }
    
    @IBAction func AddBarButton(sender: AnyObject)
    {
        self.tabBarController?.selectedIndex = 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let next = segue.destinationViewController as! ThirdViewController
        
        let selected = tblTasks.indexPathForCell(sender as! UITableViewCell)
        
        let selectedRow = selected?.row
        
        next.recievedTrainingText = excersises![selectedRow!] as! String
        next.recievedDescriptionText = descriptions![selectedRow!] as! String
    }
}

