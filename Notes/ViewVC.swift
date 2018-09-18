//
//  ViewVC.swift
//  Notes
//
//  Created by Neil Sood on 9/17/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit

protocol ViewVCDelegate: class {
    func backBtnPressed()
}

class ViewVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    weak var delegate: ViewVCDelegate?
    var data = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = data["title"]
        dateLabel.text = data["date"]
        noteLabel.text = data["note"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        delegate?.backBtnPressed()
    }
    
}
