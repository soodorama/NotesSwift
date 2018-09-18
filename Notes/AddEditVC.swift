//
//  AddEditVC.swift
//  Notes
//
//  Created by Neil Sood on 9/17/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit
import CoreData

protocol AddEditVCDelegate: class {
    func addNote(data: [String:Any?])
    func cancelPressed()
}

class AddEditVC: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    // set in delegate
    var isAdd: Bool = true
    weak var delegate: AddEditVCDelegate?
    var note = [String:Any?]()
    var data = [String:String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = data["header"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelPressed()
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        note["title"] = titleField.text
        note["note"] = noteField.text
        note["date"] = Date()
    
        // still need to get raw data for date
    
        delegate?.addNote(data: note)
    }
    
    @IBAction func calendarButton(_ sender: UIButton) {
//        let isoDate = "2016-04-14T10:44:00+0000"
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//        let date = dateFormatter.date(from:)
        
    }
    
    

}
