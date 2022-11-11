//
//  LoginViewController.swift
//  instagram-Tecsup
//
//  Created by MAC43 on 28/10/22.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPassword.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        checkSession()
    }
    
    func checkSession(){
        if Auth.auth().currentUser != nil{
            self.performSegue(withIdentifier: "seguelogin", sender: nil)
        }
    }
    
    @IBAction func onTapLogin(_ sender: UIButton) {
        if txtEmail.text == "" || txtPassword.text == "" {
            let alert = UIAlertController(title: "Error", message: "Complete fields", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "OK", style: .default)
            alert.addAction(alertButton)
            present(alert, animated: true)
            return
        }
        signIn(email: txtEmail.text!, password: txtPassword.text!)
    }
    
    func signIn(email:String, password:String){
        Auth.auth().signIn(withEmail: email, password:password){
            AuthResult, error in
            if error == nil {
                self.performSegue(withIdentifier: "seguelogin", sender: nil)
            } else {
                self.signUp(email:email, password:password)
            }
        }
    }
    
    func signUp(email:String, password:String){
        Auth.auth().createUser(withEmail: email, password: password){ AuthResult, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let alertButton = UIAlertAction(title: "ok", style: .default)
                alert.addAction(alertButton)
            } else {
                self.performSegue(withIdentifier: "seguelogin", sender: nil)
            }
        }
    }
}
