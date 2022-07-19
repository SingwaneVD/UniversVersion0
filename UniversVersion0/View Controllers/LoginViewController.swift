//
//  LoginViewController.swift
//  UniversVersion0
//
//  Created by IACD-024 on 2022/06/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var errorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
     }
     func setUpElements(){
         //for hiding the error label
         errorLbl.alpha = 0
        //styling the elements
         Utilities.styleTextField(emailTextField)
         Utilities.styleTextField(passwordTxt)

         Utilities.styleFilledButton(loginBtn)
     }

    
    @IBAction func loginTapped(_ sender: Any) {
        //validate fields
        //cleaned versions of the field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error )in
            if error != nil{
                // could not sign in
                self.errorLbl.text = error!.localizedDescription
                self.errorLbl.alpha = 1
            }
            else{
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController)as? HomeViewController
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
        
        
    }
    
}
