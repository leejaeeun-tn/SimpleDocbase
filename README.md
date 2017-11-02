## SimpleDocbase アプリ概要
Docbase APIを利用して自分のグループが閲覧できて、投稿ができる簡易アプリ

## 概要
- 自分が所属しているグループが表示できること
- 勤怠管理ができること（これはあとで実装します。）

## 画面構成
- グループリスト画面
    - メモリスト（削除）
        - 投稿詳細(編集、削除)
- メモ投稿画面(Modal)
- 勤怠管理画面
- 設定画面
    - Token登録 
    - 勤怠管理グループ登録
    - 所属チーム情報
    - バージョン情報

## 実装の時必要なスキル
- タイムライン画面
    - Docbase API利用する (Request処理)
- メモ投稿画面(Modal)
     - 作成途中の内容をアプリ内のdocumentの保存する
- 勤怠管理画面**（あとで実装します。）**
- 設定画面
    - 設定情報はUserDefaultを利用し保存する

## 画面構成

- UITabBarController基盤で作成してください。
- 各Top画面はUINavigationViewControllerで作成してください。
- 画面パーツはできるだけ、基本UIを使ってください。
