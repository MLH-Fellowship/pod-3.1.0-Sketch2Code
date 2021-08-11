//
//  HistoryTableViewCell.swift
//  Swift Co-Pilot
//
//  Created by Prabaljit Walia on 11/08/21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var codeTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
