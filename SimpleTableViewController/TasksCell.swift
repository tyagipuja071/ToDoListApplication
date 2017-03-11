//
//  TasksCell.swift
//  SimpleTableViewController
//
//  Created by Pooja Tyagi on 08/03/17.
//  Copyright © 2017 Pooja Tyagi. All rights reserved.
//

import UIKit
import QuartzCore

class TasksCell: UITableViewCell {
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDetail: UILabel!
    @IBOutlet weak var taskTimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    }
