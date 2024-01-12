//
//  ViewController.swift
//  Orders
//
//  Created by Azhad Khan on 17/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    
   
    
 
    
    //MARK: All Iboutlet
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

   
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        
        tableview.reloadData()
    }
    
}



extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentOutlet.selectedSegmentIndex {
        case 0:
            return 5
            
        case 1:
            return 10
          
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ServiceTableViewCell", for: indexPath) as! ServiceTableViewCell
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InventoryViewC") as! InventoryViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

