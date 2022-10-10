//
//  ViewController.swift
//  MiniProjectEB
//
//  Created by Putra on 10/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    private let loginLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let emailTxt: UITextField = {
        let textF = UITextField()
        textF.translatesAutoresizingMaskIntoConstraints = false
        textF.placeholder = "input your email"
        textF.borderStyle = .roundedRect
        return textF
    }()
    
    private let passTxt: UITextField = {
        let textF = UITextField()
        textF.translatesAutoresizingMaskIntoConstraints = false
        textF.isSecureTextEntry = true
        textF.placeholder = "password"
        textF.borderStyle = .roundedRect
        return textF
    }()

    private let btnLogin: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.1083075926, green: 0.3042786419, blue: 0.5136541128, alpha: 1)
        button.tintColor = .white
        return button
    }()
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.color = .black
        return indicator
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(loginLbl)
        view.addSubview(emailTxt)
        view.addSubview(passTxt)
        view.addSubview(btnLogin)
        
        view.addSubview(container)
        container.addSubview(indicator)
        container.backgroundColor = .clear
        container.isHidden = true
//        indicator.startAnimating()
        loginLbl.text = "Login Form"
        btnLogin.layer.cornerRadius = 10
        view.backgroundColor = .white
        let remote: LoginRemoteDataSourceProtocol = LoginRemoteDataSource()
        let repo: LoginRepositoryProtocol = LoginRepository(remote: remote)
        let interactor: LoginInteractorProcol = LoginInteractor(repo: repo)
        viewModel = LoginViewModel(usecase: interactor)
        viewModel?.delegate = self
        
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.addTarget(self, action: #selector(loginAct(sender:)), for: .touchUpInside)
        
        
        setupConstraint()
        
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            loginLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            loginLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTxt.topAnchor.constraint(equalTo: loginLbl.bottomAnchor, constant: 20),
            emailTxt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTxt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passTxt.topAnchor.constraint(equalTo: emailTxt.bottomAnchor, constant: 20),
            passTxt.leadingAnchor.constraint(equalTo: emailTxt.leadingAnchor),
            passTxt.trailingAnchor.constraint(equalTo: emailTxt.trailingAnchor),
            btnLogin.topAnchor.constraint(equalTo: passTxt.bottomAnchor, constant: 20),
            btnLogin.leadingAnchor.constraint(equalTo: emailTxt.leadingAnchor),
            btnLogin.trailingAnchor.constraint(equalTo: emailTxt.trailingAnchor),
            btnLogin.heightAnchor.constraint(equalToConstant: 44),
            
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            indicator.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            indicator.topAnchor.constraint(equalTo: container.topAnchor),
            indicator.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            indicator.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
        ])
    }
    
    
    @objc func loginAct(sender: UIButton) {
        print("di tap")
        container.isHidden = false
        indicator.startAnimating()
        var body = [String: String]()
        body["email"] = emailTxt.text
        body["password"] = passTxt.text
        viewModel?.login(body: body)
    }


}

extension ViewController: LoginViewModelProtocol {
    func loginSuccess() {
        print("masuk sukses")
        container.isHidden = true
        indicator.stopAnimating()
        UserDefaults.standard.setValue(emailTxt.text, forKey: "email")
        UserDefaults.standard.setValue(viewModel?.loginResponse.token, forKey: "token")

        let vc = HomeViewController()
        let remote: HomeRemoteDataSourceProtocol = HomeRemoteDataSource()
        let repo: HomeRepositoryProtocol = HomeRepository(remote: remote)
        let interactor: HomeInteractorProcol = HomeInteractor(repo: repo)
        vc.viewModel = HomeViewModel(usecase: interactor)
//        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
        if #available(iOS 13.0, *) {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.changeRootViewController(vc)
        }
        
        

        
        
    }
    
    func loginFailure(err: String) {
        container.isHidden = true
        indicator.stopAnimating()
        print("masuk failed")
    }
    
    
}

