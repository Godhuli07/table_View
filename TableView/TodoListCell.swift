//
//  TodoListCell.swift
//  TableView
//
//  Created by Godhuli on 27/02/23.
//

import UIKit

class TodoListCell: UITableViewCell {
    
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
