//
//  TableViewCell.swift
//  Orders
//
//  Created by Azhad Khan on 28/12/23.
//

import UIKit

protocol DeleteInventoryDelegate {
    func delectInventry(index:Int)
}
class TableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var delegate:DeleteInventoryDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func buttonPressedDeleteInventory(_ sender: UIButton) {
        
        self.delegate?.delectInventry(index: sender.tag)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
