//
//  AuthViewController.swift
//  KMVVM
//
//  Created by sahib-dev on 6/13/22.
//

import UIKit
import Firebase
import MMProgressHUD
import MaterialComponents

protocol AuthViewControllerDelegate: AnyObject {
    func buttonClicked(tag: Int, email: String?, password: String?)
}


class AuthViewController: UIViewController {

    
    @IBOutlet weak var emailTxt: MDCTextField!
    @IBOutlet weak var passwordTxt: MDCTextField!
    @IBOutlet weak var loginBtn: MDCButton!
    @IBOutlet weak var registerBtn: MDCButton!
    
    private var emailController: MDCTextInputControllerOutlined?
    private var passwordController: MDCTextInputControllerOutlined?

    private var authViewModel: AuthViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        authViewModel.firebaseAuthViewModelDelegate = self
        setUIs()
    }
    
    func setUIs() {
        navigationController?.setNavigationBarHidden(true, animated: true)

        emailTxt.backgroundColor = UIColor.white
        emailTxt.textColor = UIColor.black
        emailTxt.backgroundColor = UIColor.clear
        emailTxt.clearButtonMode = .never
        emailTxt.delegate = self
        emailController = MDCTextInputControllerOutlined(textInput: emailTxt)
        emailController?.borderFillColor = UIColor.white
        emailController?.normalColor = UIColor.black
        emailController?.activeColor = UIColor.black
        emailController?.inlinePlaceholderColor = UIColor.black
        emailController?.floatingPlaceholderActiveColor = UIColor.black
        passwordTxt.backgroundColor = UIColor.white
        passwordTxt.textColor = UIColor.black
        passwordTxt.backgroundColor = UIColor.clear
        passwordTxt.clearButtonMode = .never
        passwordTxt.delegate = self
        passwordController = MDCTextInputControllerOutlined(textInput: passwordTxt)
        passwordController?.borderFillColor = UIColor.white
        passwordController?.normalColor = UIColor.black
        passwordController?.activeColor = UIColor.black
        passwordController?.inlinePlaceholderColor = UIColor.black
        passwordController?.floatingPlaceholderActiveColor = UIColor.black
    }
    
    @IBAction func authAction(_ sender: Any) {
        // ... validate blank
        
        // ... action
        guard let sender = sender as? MDCButton else {return}
        MMProgressHUD.show(withStatus: "Loading...")
        let currentTag: Int = sender.tag
        authViewModel.authViewControllerDelegate?.buttonClicked(tag: currentTag,
                                                                          email: emailTxt.text,
                                                                          password: passwordTxt.text)
    }
    
}


extension AuthViewController: FirebaseAuthViewModelDelegate {
    func login() {
        if let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
            present(UINavigationController(rootViewController: mainVC), animated:true, completion: nil)
            
        }
    }
    
    func register() {
        passwordTxt.text = ""
        MMProgressHUD.dismiss(withSuccess: "REGISTER SUCCESS")
        if let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
            present(UINavigationController(rootViewController: mainVC), animated:true, completion: nil)
            
        }

    }
    
    func error(error: String, sign: Bool) {
        passwordTxt.text = ""
        MMProgressHUD.dismissWithError(error)
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        view.layoutIfNeeded()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
