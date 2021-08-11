//
//  SettingsViewController.swift
//  StoragePicturesWithPasswordApp
//
//  Created by Admin on 23.06.21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var containerForTextFieldPasswordView: UIView!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var enterCurrentPasswordTextField: UITextField!
    @IBOutlet weak var enterNewPasswordTextField: UITextField!
    @IBOutlet weak var repeatNewPasswordTextField: UITextField!
    @IBOutlet weak var showCurrentPasswordButton: UIButton!
    @IBOutlet weak var showNewPasswordButton: UIButton!
    @IBOutlet weak var showRepeatPasswordButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        enterCurrentPasswordTextField.delegate = self
        enterNewPasswordTextField.delegate = self
        repeatNewPasswordTextField.delegate = self
        setupChangePasswordButton()
        setupTextField()
        setupContainerForTextFieldPasswordView()
        localization()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    @IBAction func closedContainerForTextFieldPasswordButtonPressed(_ sender: UIButton) {
        setupTextField()
        containerForTextFieldPasswordView.alpha = 0
        changePasswordButton.isEnabled = true
    }

    @IBAction func changePasswordButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 1) {
            sender.isEnabled = false
            self.containerForTextFieldPasswordView.alpha = 1
            self.enterCurrentPasswordTextField.becomeFirstResponder()
        }
    }

    @IBAction func showCurrentPasswordButtonPressed(_ sender: UIButton) {
        showAndSecureTextEntry(sender, enterCurrentPasswordTextField)

    }

    @IBAction func showNewPasswordButtonPressed(_ sender: UIButton) {
        showAndSecureTextEntry(sender, enterNewPasswordTextField)
    }

    @IBAction func showRepeatNewPasswordButtonPressed(_ sender: UIButton) {
        showAndSecureTextEntry(sender, repeatNewPasswordTextField)
    }

    private func setupContainerForTextFieldPasswordView() {
        containerForTextFieldPasswordView.backgroundColor = .white
        containerForTextFieldPasswordView.alpha = 0
    }

    private func setupChangePasswordButton() {
        changePasswordButton.layer.cornerRadius = changePasswordButton.frame.height / 3
    }

    private func localization() {
        changePasswordButton.setTitle("changePasswordButton".localized, for: .normal)
        enterCurrentPasswordTextField.placeholder = "enterPassword".localized
        enterNewPasswordTextField.placeholder = "enterNewPassword".localized
        repeatNewPasswordTextField.placeholder = "repeatPassword".localized
    }

    private func setupTextField() {
        enterCurrentPasswordTextField.resignFirstResponder()
        enterNewPasswordTextField.resignFirstResponder()
        repeatNewPasswordTextField.resignFirstResponder()
        enterCurrentPasswordTextField.isSecureTextEntry = true
        enterNewPasswordTextField.isSecureTextEntry = true
        repeatNewPasswordTextField.isSecureTextEntry = true
        enterCurrentPasswordTextField.text?.removeAll()
        enterNewPasswordTextField.text?.removeAll()
        repeatNewPasswordTextField.text?.removeAll()
        enterNewPasswordTextField.isHidden = true
        repeatNewPasswordTextField.isHidden = true
        showNewPasswordButton.isHidden = true
        showRepeatPasswordButton.isHidden = true
        showCurrentPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        showNewPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        showRepeatPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
    }

    private func showAndSecureTextEntry(_ sender: UIButton, _ textField: UITextField) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
            textField.isSecureTextEntry = false
        } else {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            textField.isSecureTextEntry = true
        }
    }
}
