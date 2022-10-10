//
//  HomeViewController.swift
//  MiniProjectEB
//
//  Created by Putra on 10/10/22.
//

import UIKit

class HomeViewController: UIViewController {

    private let table: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListUserTableViewCell.self, forCellReuseIdentifier: ListUserTableViewCell.identifier)
        return tableView
    }()
    
    private let emailUser: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let btnLogout: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.5407512784, green: 0.1525711715, blue: 0.1538901031, alpha: 1)
        button.tintColor = .white
        return button
    }()
    
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(emailUser)
        view.addSubview(table)
        view.addSubview(btnLogout)
        view.backgroundColor = .white
//        table.backgroundColor = .brown
        table.delegate = self
        table.dataSource = self
        btnLogout.setTitle("Logout", for: .normal)
        btnLogout.layer.cornerRadius = 10
        viewModel.delegate = self
        emailUser.text = UserDefaults.standard.string(forKey: "email")
        setupConstraint()
        viewModel.getList()
        btnLogout.addTarget(self, action: #selector(logoutTapped(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            emailUser.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailUser.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            emailUser.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            btnLogout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            btnLogout.topAnchor.constraint(equalTo: emailUser.bottomAnchor, constant: 30),
            btnLogout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.topAnchor.constraint(equalTo: btnLogout.bottomAnchor, constant: 20),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func logoutTapped(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "token")
        let vc = ViewController()
        if #available(iOS 13.0, *) {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.changeRootViewController(vc)
        }
        
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.userRespnse.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListUserTableViewCell.identifier, for: indexPath) as? ListUserTableViewCell else {return UITableViewCell()}
        cell.setupData(data: (viewModel?.userRespnse[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension HomeViewController: HomeViewModelProtocol {
    func getListUserSuccess() {
        print("masuk sukses")
        table.reloadData()
    }
    
    func getListUserFailed(err: String) {
        print("error = \(err)")
    }
    
    
}
