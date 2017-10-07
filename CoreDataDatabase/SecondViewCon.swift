//
//  SecondViewCon.swift
//  CoreDataDatabase
//
//  Created by Mostafa on 7/14/17.
//  Copyright © 2017 Mostafa. All rights reserved.
//

import UIKit
import CoreData

class SecondViewCon: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    @IBOutlet weak var mytable: UITableView!
    var userarr:[String] = [String]()
    
    override func viewDidLoad() {
        self.mytable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.fetchData()
        self.mytable.reloadData()
    }
    
    func fetchData(){
        
        let appDeleg:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDeleg.managedObjectContext
        
        do{
            let request = NSFetchRequest(entityName: "UserInfo")
            let results = try context.executeFetchRequest(request)
            for item in results as! [NSManagedObject]{
                let firstname = item.valueForKey("firstName") as! String
                let lastname  = item.valueForKey("lastName") as! String
                self.userarr.append(firstname + " " + lastname)
            }
            
        }catch{
            print("error in fetching data")
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userarr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
        cell.textLabel?.text = self.userarr[indexPath.row]
        return cell
    }
}
