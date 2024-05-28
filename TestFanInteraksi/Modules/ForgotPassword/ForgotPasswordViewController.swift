//
//  ForgotPasswordViewController.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate{
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Input your email"
        textField.delegate = self
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .systemFill
        textField.addTarget(target: self, selector: #selector(textDidChange(_:)), for: .editingChanged)
        textField.validation = [.isAValidEmailAddress]
        return textField
    }()
    lazy var button: CustomButton = {
        let button = CustomButton(frame: .zero, backgroundColor: .primaryButton, pressedColor: .primaryButtonPressed)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.setTitle("Forgot password", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return button
    }()
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var usernameTextView: CustomTextField = {
        let textView = CustomTextField()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var presenter: ForgotPasswordPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addContainer()
        addStackView()
        addEmailTextField()
        addForgotPasswordButton()
        setupTextField()
        addErrorLabel()
    }
    
    private func addContainer(){
        view.addSubview(containerView)
        
        let height = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.6, constant: 0)
        height.priority = .defaultLow
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0),            NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: view, attribute: .height, multiplier: 0.6, constant: 0),
            height
        ])
    }
    
    private func addStackView(){
        containerView.addSubview(textFieldStackView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: textFieldStackView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: containerView, attribute: .top, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: textFieldStackView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textFieldStackView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textFieldStackView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: textFieldStackView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: textFieldStackView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: containerView, attribute: .bottom, multiplier: 1, constant: -20)
        ])
    }
    
    private func addEmailTextField(){
        textFieldStackView.addArrangedSubview(emailTextField)
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func addForgotPasswordButton(){
        textFieldStackView.addArrangedSubview(button)
        button.widthAnchor.constraint(equalTo: emailTextField.widthAnchor, multiplier: 1).isActive = true
        button.heightAnchor.constraint(equalTo: emailTextField.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func setupTextField(){
        emailTextField.shouldValidate = true
        button.isEnabled = false
        button.setTitle("Sign in", for: .normal)
    }
    
    private func addErrorLabel(){
        textFieldStackView.addArrangedSubview(statusLabel)
        statusLabel.heightAnchor.constraint(equalTo:emailTextField.heightAnchor, multiplier: 1).isActive = true
    }
    
    @objc func forgotPassword(){
        guard let text = emailTextField.text else{return}
        presenter?.userClickForgotPassword(email: text)
    }
    
    @objc func textDidChange(_ sender: UITextField){
        updateButton()
    }
    
    func updateButton(){
        let enabled = emailTextField.status == .valid
        print(enabled)
        button.isEnabled = enabled
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewProtocol{
    func updateStatusLabel(text: String, isError: Bool) {
        statusLabel.text = text
        statusLabel.textColor = isError ? .red:.green
    }
}
