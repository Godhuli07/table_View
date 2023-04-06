//
//  TableViewCell.swift
//  TableView
//
//  Created by Godhuli on 21/02/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameList: UILabel!
    
    @IBOutlet weak var usernameList: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
