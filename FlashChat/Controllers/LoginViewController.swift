
import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let pass = passwordTextField.text{
            // FireBase auth obj
            Auth.auth().signIn(withEmail: email, password: pass) { [weak self] authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self!.performSegue(withIdentifier: "Login", sender: self )
                    
                }
                
            }
        }
    }
    
    
}
