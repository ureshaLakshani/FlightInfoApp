//
//  SignInVC.swift
//  FlightLinfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import UIKit
import Lottie

class SignInVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var animationView: AnimationView!
    
    //MARK: - Variables
    let vm = SignInVM()
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
    @IBAction func TappedSignUp(_ sender: Any) {
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tappedSignIn(_ sender: Any) {
        
        if vm.validateEmailAddress(email: emailTF.text ?? "") && vm.validatePasswordField(password: passwordTF.text ?? ""){
            self.signinWithFirebaseAuth()
        }else{
            let alert = UIAlertController(title: "Error", message: "Please enter valid email & password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

//Firebase signin request
extension SignInVC{
    func signinWithFirebaseAuth(){
        self.activityIndicator.startAnimating()
        vm.signInWithFirebaseUser(email: emailTF.text ?? "", password: passwordTF.text ?? ""){status,code,message in
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
