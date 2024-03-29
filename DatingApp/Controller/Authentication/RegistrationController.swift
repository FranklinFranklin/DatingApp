//
//  RegistrationController.swift
//  DatingApp
//
//  Created by BookMAc on 9/9/21.
//

import UIKit

class RegistrationController: UIViewController {
    
    private var viewModel = RegistrationViewModel()
    
    private let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(handldeSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let fullnameTextField = CustomTextField(placeholder: "Full Name")
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecureField: true)
    
    private var profileImage: UIImage?
    
    private let authButton: AuthButton = {
        let button = AuthButton(title: "Sign Up", type: .system)
        button.addTarget(self, action: #selector(handleRegistrationUser), for: .touchUpInside)
        return button
    }()
    
    private let goToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ",
                                                        attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16)])
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [.foregroundColor: UIColor.white, .font:UIFont.boldSystemFont(ofSize: 16)]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFieldObservers()
        configureUI()
        setupToHideKeyboardOnTapOnView()
        
        
    }
    
    @objc func handleRegistrationUser() {
        guard let email = emailTextField.text else {return}
        guard let fullname = fullnameTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let profileImage = profileImage else {return}
        
        let credentials = AuthCredentials(email: email, password: password,
                                          fullname: fullname, profileImage: profileImage)
     
        AuthService.registerUser(withCredentials: credentials) { error in if let error = error {
            print("DEBUG: Error signing user up \(error.localizedDescription)")
            return
        }
        self.dismiss(animated: true, completion: nil)
        print("DEBUG: Successfully registerd user...")
        
        }
    }
    
    @objc func handldeSelectPhoto() {
        print("DEBUG: Handle slect photo here...")
        // selecting a photo from your album
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    
    @objc func handleShowLogin() {
        //remove the navigation from stack
        navigationController?.popViewController(animated: true)
        //print("DEBUG: ")
    }
    
    @objc func textDidChange(sender: UITextField) {
        //self.view.endEditing(true)
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField{
            viewModel.password = sender.text
        } else {
            viewModel.fullname = sender.text
        }
       
     checkFormStatus()
    }
    
    @objc func dismissKeyboard()
      {
          view.endEditing(true)
      }
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            authButton.isEnabled = true
            authButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        } else {
            authButton.isEnabled = false
            authButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
    
    
    func configureUI() {
       configureGradientLayer()
       
        view.addSubview(selectPhotoButton)
        selectPhotoButton.setDimensions(height: 275, width: 275)
        selectPhotoButton.centerX(inView: view)
        selectPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,fullnameTextField,passwordTextField, authButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: selectPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(goToLoginButton)
        goToLoginButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32,paddingRight: 32)
    }
    
    func configureTextFieldObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
        
    }
    
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //image pickercontroller is je local foto album
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImage = image
        selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        selectPhotoButton.layer.borderWidth = 3
        selectPhotoButton.layer.cornerRadius = 10
        selectPhotoButton.imageView?.contentMode = .scaleAspectFill
        
        
        dismiss(animated: true, completion: nil)
    }
}

extension RegistrationController
{
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(RegistrationController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
