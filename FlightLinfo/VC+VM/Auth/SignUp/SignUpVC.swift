//
//  SignUpVC.swift
//  FlightLinfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import UIKit
import Lottie

class SignUpVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPwdTF: UITextField!
    @IBOutlet weak var animationView: AnimationView!
    
    //MARK: - Variables
    let vm = SignUpVM()
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        
        displayAnimationGif()
        // set up activity indicator
        activityIndicator.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        activityIndicator.color = UIColor.purple
        self.view.addSubview(activityIndicator)
    }
    
    // call fuction to display noItem Gif
    func displayAnimationGif(){
        //  Set animation content mode
        animationView.contentMode = .scaleAspectFit
        //Set animation loop mode
        animationView.loopMode = .loop
        //Adjust animation speed
        animationView.animationSpeed = 0.5
        //Play animation
        animationView.play()
        
    }
    
    
    //MARK: - Actions
    @IBAction func tappedSignUp(_ sender: Any) {
        
        if(passwordTF.text != self.confirmPwdTF.text){
            let alert = UIAlertController(title: "Sign Up Failed", message: "Sorry, your Passwords were not matching.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            
            self.present(alert, animated: true, completion: nil)
        } else if  vm.validateEmailAddress(email: emailTF.text ?? "") && vm.validatePasswordField(password: passwordTF.text ?? ""){
            self.signupWithFirebaseAuth()
        }else{
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: "Please enter valid email & password", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func tappedSignIn(_ sender: Any) {
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

//Firebase singup request
extension SignUpVC{
    
    func signupWithFirebaseAuth(){
        self.activityIndicator.startAnimating()
        vm.signUpWithFirebaseUser(email: emailTF.text ?? "", password: passwordTF.text ?? ""){ status,code,message in
            self.activityIndicator.stopAnimating()
            if !status{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
}
