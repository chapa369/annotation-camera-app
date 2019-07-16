# camera_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## なんのアプリか
SSDなどの物体検出アルゴリズムの教師データ集めのためのアノテーション作業が面倒くさいので、
写真を撮ると同時にjpgファイルとバウンディングボックスのjsonファイルが生成されるようなアプリを作った。

## 使い方
- アプリ起動する
- 横向きにする（ボタンが右側）
- 四角のボタンを押す。
- バウンディングボックスを描画するためにカメラプレビュー上で任意の２点をタップするとその２点を対角線とするボックスが出現
- この状態でカメラマークを押すと、写真とバウンディングボックスのjsonファイルが保存される

# 諸々の注意点
使用上の注意は３つ！すべて僕のコーディング力不足に由来するものです！（土下座）

- バウンディングボックスの座標などを考慮するのが大変だったので、Nexus 6に対応した座標をハードコーディングしています。
なので、別機種でこのアプリを使用する場合には細かな調整が必要になるかもしれません。というか、なります。
ご了承ください。

- 右利きの人が横向きで使うことを想定した仕様になっています。
縦向きで使用するとバウンディングボックスの位置がずれます。
カメラの撮影ボタンが右側に来るような向きで使用してください。

- 中心部分（赤枠で囲まれている部分）をクロップし、640*640に変換することを前提に座標値を吐き出しています。
  - これはflutterのカメラ系のAPIで細かいサイズ指定ができないので仕方がなかった。