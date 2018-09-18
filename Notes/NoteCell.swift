//
//  NoteCell.swift
//  Notes
//
//  Created by Neil Sood on 9/17/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBAction func checkPressed(_ sender: UIButton) {
        if checkButton.backgroundImage(for: .normal) == UIImage(named: "checked") {
            let image = UIImage(named: "unchecked")
            checkButton.setBackgroundImage(image, for: .normal)
        }
        else {
            let image = UIImage(named: "checked")
            checkButton.setBackgroundImage(image, for: .normal)
        }
    }
}
