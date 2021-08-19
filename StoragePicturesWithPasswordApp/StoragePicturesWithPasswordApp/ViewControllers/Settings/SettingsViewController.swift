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
    @IBOutlet weak var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        enterCurrentPasswordTextField.delegate = self
        enterNewPasswordTextField.delegate = self
        repeatNewPasswordTextField.delegate = self
        setupContainerForTextFieldPasswordView()
        localization()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    @IBAction func changePasswordButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setTitle("cancel".localized, for: .normal)
            enterCurrentPasswordTextField.becomeFirstResponder()
            UIView.animate(withDuration: 1) {
                self.containerForTextFieldPasswordView.alpha = 1
            }
        } else {
            sender.setTitle("changePasswordButton".localized, for: .normal)
            enterCurrentPasswordTextField.resignFirstResponder()
            enterNewPasswordTextField.resignFirstResponder()
            repeatNewPasswordTextField.resignFirstResponder()
            UIView.animate(withDuration: 1) {
                self.containerForTextFieldPasswordView.alpha = 0
            }
        }
    }

    @IBAction func secureCurrentPasswordButtonPressed(_ sender: UIButton) {
        showOrHidenText(sender, enterCurrentPasswordTextField)
    }

    @IBAction func secureNewPasswordButtonPressed(_ sender: UIButton) {
        showOrHidenText(sender, enterNewPasswordTextField)
    }

    @IBAction func secureRepeatPasswordButtonPressed(_ sender: UIButton) {
        showOrHidenText(sender, repeatNewPasswordTextField)
    }

    @IBAction func continueButtonPressed(_ sender: UIButton) {
        if validateCurrentPassword(),
           validateNewPassword(),
           validateRepeatPassword() {
            guard let password = repeatNewPasswordTextField.text else {
                return
            }
            PasswordManager.shared.save(password)
            createAlert("changedPassword".localized)
            changePasswordButton.setTitle("changePasswordButton".localized, for: .normal)
            changePasswordButton.isSelected = false
            UIView.animate(withDuration: 1) {
                self.containerForTextFieldPasswordView.alpha = 0
            }
        }
    }

    private func setupContainerForTextFieldPasswordView() {
        containerForTextFieldPasswordView.backgroundColor = .clear
        containerForTextFieldPasswordView.alpha = 0
    }

    private func localization() {
        changePasswordButton.setTitle("changePasswordButton".localized, for: .normal)
        continueButton.setTitle("continue".localized, for: .normal)
        enterCurrentPasswordTextField.placeholder = "enterPassword".localized
        enterNewPasswordTextField.placeholder = "enterNewPassword".localized
        repeatNewPasswordTextField.placeholder = "repeatPassword".localized
    }
}
