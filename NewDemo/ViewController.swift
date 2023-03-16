//
//  ViewController.swift
//  NewDemo
//
//  Created by Vaibhav on 24/09/21.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var nameErrorLbl: UILabel!
    @IBOutlet weak var nameTxtF: UITextField!
    
    @IBOutlet weak var passErrorLbl: UILabel!
    @IBOutlet weak var passTxtF: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    private let bag = DisposeBag()
    private let viewModel = LoginViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        nameErrorLbl.text = ""
        passErrorLbl.text = ""
        
        //Initially login button will be disable
        toggleButton(enable: false)
        setUpBindings()
    }

    
    func setUpBindings() {
        
        nameTxtF.rx.text.bind(to: viewModel.username).disposed(by: bag)
        passTxtF.rx.text.bind(to: viewModel.password).disposed(by: bag)
        
        
        viewModel.isValidLogin
            .subscribe(onNext: { [weak self] (isValid) in
                print(isValid)
                self?.toggleButton(enable: isValid)
            }).disposed(by: bag)
        
        viewModel.isValidUserName
            .subscribe(onNext: { [weak self] (isValid) in
                self?.nameErrorLbl.text = (isValid ? "" : DemoConstants.nameFormatError)
            }).disposed(by: bag)
        
        viewModel.isValidPassword
            .subscribe(onNext: {  [weak self] (isValid) in
                self?.passErrorLbl.text = (isValid ? "" : DemoConstants.passwordFormatError)
            }).disposed(by: bag)
    }

    
    @IBAction func doLogin() {
        let vc = LandingVC.createVC(name: nameTxtF.text ?? "")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /// To set login button enable or disable
    /// - Parameter enable: Boolean value to enable or disabel login button
    func toggleButton(enable: Bool) {
        loginBtn.isEnabled = enable
        loginBtn.backgroundColor = (enable ? UIColor(red: 77.0/255.0, green: 162.0/255.0, blue: 180.0/255.0, alpha: 1) : .lightGray)
    }
}
