//
//  ViewController.swift
//  starwars-app
//
//  Created by ShahJee on 18/10/2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = titleString
        descLbl.text = descString
    }

    var titleString: String = ""
    var descString: String = ""
    
    func setupView(withTitle title: String, desc: String) {
        titleString = title
        descString = desc
    }
}

