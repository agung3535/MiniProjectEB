//
//  ListUserTableViewCell.swift
//  MiniProjectEB
//
//  Created by Putra on 10/10/22.
//

import UIKit

class ListUserTableViewCell: UITableViewCell {
    
    static let identifier = "ListUserTableViewCell"
    
    private let imageUser: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.contentMode = .scaleToFill
        return imageV
    }()
    
    private let email: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(imageUser)
        addSubview(email)
        addSubview(name)
        
        setupConstraint()
    }
    
    func setupData(data: UserResource) {
        let url = URL(string: data.avatar ?? "")
        let dataImage = try? Data(contentsOf: url!)
        imageUser.image = UIImage(data: dataImage!)
        email.text = data.email
        name.text = "\(data.firstName ?? "") \(data.lastName ?? "")"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            imageUser.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageUser.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            imageUser.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            imageUser.widthAnchor.constraint(equalToConstant: 30),
            imageUser.heightAnchor.constraint(equalTo: imageUser.widthAnchor, multiplier: 1.0),
            
            email.leadingAnchor.constraint(equalTo: imageUser.trailingAnchor, constant: 20),
            email.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            email.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            name.leadingAnchor.constraint(equalTo: imageUser.trailingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            name.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10),
            name.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
