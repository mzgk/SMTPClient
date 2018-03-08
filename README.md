# MailCore2を使った、バックグラウンドでのメール送信

## cocoaPods
mailcore2-iosをインポート

## Bridging-Header.h
1. Bridging-Header.hの作成
    - new file -> Header File -> プロジュエクト名-Bridging-Header.h
	- 作成したheaderファイルに「#import <MailCore/MailCore.h>」を追加
2. TARGET: Build Settingに以下を設定
	- Search Paths -> Header Search Paths -> "${PODS_ROOT}/Headers/Public/mailcore2-ios/MailCore"を追加（""で括る）
	- Swift Compiler-General -> Objective-C Bridging Header -> 「$(SRCROOT)/$(PROJECT)/$(SWIFT_MODULE_NAME)-Bridging-Header.h」を追加
	- ""で括らないこと（作成したBridging-Header.hのパス）
3. ⌘ + bでビルドが通ること

## Gmailを使用する場合
- Gmail側でセキュリティの設定が必要になる（Gmailからメールが来る）
- 安全性の低いアプリのアクセスを無効 -> 有効にする必要がある