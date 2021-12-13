//  ViewController.swift
//  Bucket List

import UIKit
import CoreData

class ViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
    var items = [BucketListItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FetchData()
    }
    //////////////////////////////////Table view functions /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        // All UITableViewCell objects have a build in textLabel so set it to the model that is corresponding to the row in array
        cell.textLabel?.text = items[indexPath.row].itemText!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
           let navigationController = segue.destination as! UINavigationController
           let addItemTableVC = navigationController.topViewController as! addItemTableViewController
           addItemTableVC.delegate = self
        
        if sender is NSIndexPath {
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            addItemTableVC.item = item.itemText!
            addItemTableVC.indexPath = indexPath
        }
    
    }
    
    func addItemViewController(_ controller: addItemTableViewController, didFinishAddingItem text: String, at indexPath: NSIndexPath?) {
        if let ip = indexPath {
            let item = items[ip.row]
            item.itemText = text
        }
        else{
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.itemText = text
            items.append(item)
        }
        
        do{
           try managedObjectContext.save()
                    
        } catch{print("\(error)")}
        
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
    func cancelItemViewController(_ controller: addItemTableViewController, didPressCancelButton button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    //function for delete with a swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        
        do{
           try managedObjectContext.save()
        } catch{print("\(error)")}
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    //function perform something to a clicked row
//        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            
//    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "ItemSegue", sender: indexPath)
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////DataBase Function///////////////////////////////////////////////////////////////////////////////////////////////////
    func FetchData(){
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
            
            do{
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
            }
            catch
            {
                print("\(error)")
            }
    }
    
    
}
