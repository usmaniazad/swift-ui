//
//  LandingVC.swift
//  NewDemo
//
//  Created by Vaibhav on 24/09/21.
//

import UIKit

class LandingVC: UIViewController {
    
    @IBOutlet weak var textLbl: UILabel!
    
    var userName: String?
    
    static func createVC(name: String) -> LandingVC {
      let viewCon = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LandingVC") as LandingVC
        viewCon.userName = name
        return viewCon
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Authentication successful
        textLbl.text = "Hello \(userName ?? "")"
    }
}
