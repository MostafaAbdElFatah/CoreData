

import UIKit
import CoreData

class SecondViewCon: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    @IBOutlet weak var mytable: UITableView!
    var userarr:[String] = [String]()
    
    override func viewDidLoad() {
        self.mytable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.fetchData()
        self.mytable.reloadData()
    }
    
    func fetchData(){
        
        let appDeleg:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDeleg.managedObjectContext
        
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
            let results = try context.fetch(request) as! [NSManagedObject]
            for item in results {
                let firstname = item.value(forKey: "firstName") as! String
                let lastname  = item.value(forKey: "lastName") as! String
                self.userarr.append(firstname + " " + lastname)
            }
            
        }catch{
            print("error in fetching data")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userarr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.userarr[indexPath.row]
        return cell
    }
}
