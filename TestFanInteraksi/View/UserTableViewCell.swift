//
//  UserTableViewCell.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import UIKit

class UserTableViewCell: UITableViewCell{
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var verificationlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addStackView()
        addEmailLabel()
        addNameLabel()
        addVerificationLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addStackView(){
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0)
        ])
    }
    
    func addEmailLabel(){
        stackView.addArrangedSubview(emailLabel)
    }
    
    func addNameLabel(){
        stackView.addArrangedSubview(nameLabel)
    }
    
    func addVerificationLabel(){
        addSubview(verificationlabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: verificationlabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: verificationlabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: verificationlabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0)
        ])
    }
    
    func setupCell(user: UserProfileModel){
        self.emailLabel.text = user.email
        self.nameLabel.text = user.name
        self.verificationlabel.text = (user.isVerified ?? false) ? "verified":"not verified"
    }
}
