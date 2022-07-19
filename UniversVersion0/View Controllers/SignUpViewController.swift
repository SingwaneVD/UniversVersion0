//
//  SignUpViewController.swift
//  UniversVersion0
//
//  Created by IACD-024 on 2022/06/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet var firstNameTxt: UITextField!
    @IBOutlet var lastNameTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var studentNumText: UITextField!
    @IBOutlet var signUpBtn: UIButton!
    @IBOutlet var errorLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       setUpElements()
        
        
        //paste victor's version here
       // Utilities.TxtPlaceHolder(firstNameTxt)
        firstNameTxt.attributedPlaceholder = NSAttributedString(
            string: "First Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText]
        )
    }
    func setUpElements(){
        //for hiding the error label
        errorLbl.alpha = 0
       //styling the elements
        Utilities.styleTextField(firstNameTxt)
        Utilities.styleTextField(lastNameTxt)
        Utilities.styleTextField(emailTxt)
        Utilities.styleTextField(passwordTxt)
        Utilities.styleTextField(studentNumText)
        Utilities.styleFilledButton(signUpBtn)
    }
    
    
    //check and validate the data, if everything is correct retrun nil else return error message
    func validateFields()->String?{
        
        if firstNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            passwordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            studentNumText.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" {
            
        return "Please fill in all fields."
    }
        //making sure if the password is secure
        let cleanedPassword = passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
         
        if Utilities.isPasswordValid(cleanedPassword) == false{
            //if it is not secured
            return "Make sure your password is at least 8 characters, special character, and a number"
        }
        return nil
     }
    
    @IBAction func signUpTapped(_ sender: Any) {
        //validate the fields
        let error = validateFields()
        if error != nil{
            //there's an error in the fields show error message
          showError(error!)
        }else{
            //Create cleaned versions of the data,,,,,removing all white spaces and new lines
            let firstName = firstNameTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTxt .text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let studentNum = studentNumText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: password) { result, erro in
              // check for erris
                if erro != nil{
                    //There was an error in creating the user
                    self.showError("Error in creating user")
            
                }else{
                    //user created and now add firstname and last name
                    
                    let db = Firestore.firestore()
                    //db.collection("Users").addDocument(data: ["firstname": ,"lastname":],completion:((Error)_>.....))//incomplete
                    db.collection("Users").addDocument(data: ["firstname": firstName, "lastName": lastName, "uid": result!.user.uid]) { (error) in
                        if error != nil {
                            //show error message
                            self.showError("Error saving data")
                        }
                    }
                    //Transition to the home screen
                    self.transitionToHome()
                }
            }
        }
     
       
        
    }
    func showError(_ message:String){
        errorLbl.text = message
        errorLbl.alpha = 1
    }
    func transitionToHome(){
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeViewController)as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}










