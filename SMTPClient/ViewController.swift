//
//  ViewController.swift
//  SMTPClient
//
//  Created by Mizugaki on 2018/03/08.
//  Copyright © 2018年 edu.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendButtonTapped(_ sender: UIButton) {
        // Gmailの場合、Gmail側の設定で安全性の低いアプリへのアクセスを無効 -> 有効にする必要がある
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.username = "----@gmail.com"    // 送信元のSMTPサーバーのusername（Gmailアドレス）
        smtpSession.password = "----"           // 送信元のSMTPサーバーのpasword（Gmailパスワード）
        smtpSession.port = 465
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }

        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: "自分へ", mailbox: "----@gmail.com")]        // 送信先の表示名とアドレス
        builder.header.from = MCOAddress(displayName: "自分から", mailbox: "----@gmail.com")   // 送信元の表示名とアドレス
        builder.header.subject = "MailCoreでのテストメール"
//        builder.htmlBody = "Yo Rool, this is a test message!"
        builder.textBody = "これはテスト用のテキストメッセージです"
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data)
        sendOperation?.start { (error) -> Void in
            if let error = error {
                NSLog("Error sending email: \(String(describing: error))")
            } else {
                NSLog("Successfully sent email!")
            }
        }
    }
    
}

