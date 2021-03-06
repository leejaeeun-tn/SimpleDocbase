
//
//  RegisterTokenKeyViewController.swift
//  SimpleDocbase
//
//  Created by jeonsangjun on 2017/11/17.
//  Copyright © 2017年 archive-asia. All rights reserved.
//

import UIKit
import SwiftyFORM
import SVProgressHUD

class RegisterTokenKeyViewController: FormViewController {

    enum AlertAction {
        case success
        case delete
    }

    // MARK: Properties
    let userDefaults = UserDefaults.standard
    let footerView = SectionFooterViewFormItem()
    let footerMessage = "\nDocBaseから\n「個人設定」→「基本設定」→「APIトークン」を\n作成して表示されたトークンを登録してください。"

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenKeySubmitButton()
    }

    override func populate(_ builder: FormBuilder) {
        configureFooterView()
        builder.navigationTitle = "APIトークン登録"
        builder.toolbarMode = .simple
        builder += SectionHeaderTitleFormItem().title("APIトークン登録")
        builder += tokenKey
        builder += footerView
    }
    
    lazy var tokenKey: TextFieldFormItem = {
        let instance = TextFieldFormItem()
        instance.placeholder("APIトークンを入力してください。")
        if let tokenKey = userDefaults.object(forKey: "tokenKey") as? String{
            instance.value = tokenKey
        }
        return instance
    }()
    
    // MARK: Internal Methods
    
    // MARK: Private Methods
    private func tokenKeySubmitButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登録", style: .plain, target: self, action: #selector(tokenKeySubmitAction))
    }
    
   @objc private func tokenKeySubmitAction() {
        if tokenKey.value.isEmpty {
            // TODO: Check TokenKey Delete Alert PopUp
            tokenKeyAlert(type: .delete)
        } else {
            // TODO: normally Regist TokenKey
            userDefaults.set(tokenKey.value, forKey: "tokenKey")
            userDefaults.removeObject(forKey: "selectedGroup")
            ACATeamRequest().getTeamList(completion: { teams in
                self.userDefaults.set(teams?.first, forKey: "selectedTeam")
            })
            tokenKeyAlert(type: .success)
        }
    }
    
    private func tokenKeyAlert(type: AlertAction) {
        var alert = UIAlertController()
        switch type {
        case .success:
            alert = UIAlertController(title:"APIトークン登録", message: "APIトークンを登録しました。", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "確認", style: .default) { action in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okButton)
        case .delete:
            alert = UIAlertController(title:"APIトークン削除", message: "APIトークンを削除しますか。", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "確認", style: .default) { action in
                self.userDefaults.removeObject(forKey: "tokenKey")
                self.userDefaults.removeObject(forKey: "selectedTeam")
                self.userDefaults.removeObject(forKey: "selectedGroup")
                self.navigationController?.popViewController(animated: true)
            }
            let cancelButton = UIAlertAction(title: "キャンセル", style: .cancel)
            
            alert.addAction(okButton)
            alert.addAction(cancelButton)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    private func configureFooterView() {
        footerView.viewBlock = {
            return InfoView(frame: CGRect(x: 0, y: 0, width: 0, height: 80), text: self.footerMessage)
        }
    }
    
}
