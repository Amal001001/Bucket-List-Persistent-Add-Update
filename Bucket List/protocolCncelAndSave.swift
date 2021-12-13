//
//  protocolCncelAndSave.swift
//  Bucket List
//
//  Created by admin on 12/12/2021.
//

import UIKit
protocol AddItemTableViewControllerDelegate {
    func addItemViewController(_ controller: addItemTableViewController, didFinishAddingItem text: String, at atIndexPath: NSIndexPath?)
    func cancelItemViewController(_ controller: addItemTableViewController, didPressCancelButton button: UIBarButtonItem) 
}
