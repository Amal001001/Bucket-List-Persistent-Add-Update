//  ViewController.swift
//  Bucket List

import UIKit

class ViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
    var items = ["Sky diving", "Live in Hawaii"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        // All UITableViewCell objects have a build in textLabel so set it to the model that is corresponding to the row in array
        cell.textLabel?.text = items[indexPath.row]
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
           let navigationController = segue.destination as! UINavigationController
           let addItemTableVC = navigationController.topViewController as! addItemTableViewController
           addItemTableVC.delegate = self
        
        if sender is NSIndexPath {
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            addItemTableVC.item = item
            addItemTableVC.indexPath = indexPath
        }
    
    }
    
    func addItemViewController(_ controller: addItemTableViewController, didFinishAddingItem item: String, at indexPath: NSIndexPath?) {
        if let ip = indexPath {
            items[ip.row] = item
        }
        else{
            items.append(item)
        }
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
    func cancelItemViewController(_ controller: addItemTableViewController, didPressCancelButton button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //function for delete with a swipe
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            items.remove(at: indexPath.row)
            tableView.reloadData()
        }
    
    //function perform something to a clicked row
//        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            
//        }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "ItemSegue", sender: indexPath)
    }
}
