//
//  SearchVC.swift
//  GH
//
//  Created by Aman Gupta on 16/03/24.
//

import UIKit

class SearchVC: UIViewController {

    let logoImage = UIImageView()
    let userNameTextField  = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    var isUsernameEntered: Bool{
        return !userNameTextField.text!.isEmpty
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    func createDismissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    @objc func pushFollowerListVC(){
        
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty UserName", message:"Please enter a username. We need to know who to look for" , buttonTitle: "OK")
            return
        }
        let followerList = FollowersListVC()
        followerList.userName = userNameTextField.text
        followerList.title = userNameTextField.text
        navigationController?.pushViewController(followerList, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true 
        
        
    }
    
    func configureLogoView(){
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(named:"gh-logo")
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
        ])
            
    }
    
    func configureTextField(){
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 50),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    
    func configureCallToActionButton(){
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self,action: #selector(pushFollowerListVC),for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToActionButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    
}

extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}

#Preview{
    SearchVC()
}

