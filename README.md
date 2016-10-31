
---
title: BeacappSDK
description: Beacapp SDK for Cordova.
---

# cordova-plugin-beacapp

このプラグインは、BeacappSDKをCordovaから呼び出すためのプラグインです。
BeacappSDKについては、下記のリンクをそれぞれご確認ください。

[BeacappSDK for Android(Github)](https://github.com/JMASystems/beacapp-sdk-android)

[BeacappSDK for iOS(Github)](https://github.com/JMASystems/beacapp-sdk-ios)

[Beacappを使って簡単なアプリを作ってみる(Qiita)](http://qiita.com/JMASystems/items/b57c2689d22a42cbe36e)

```js
document.addEventListener("deviceready", onDeviceReady, false);
function onDeviceReady() {
  beacappSDK.initialize("AccessToken","SecretKey",function(success){},function(error){});
}
```

## function

### initialize: function(requestToken,secretKey,success, fail)
BeacappSDKの初期化を行う


### startUpdateEvents: function(success, fail)
イベントのアップデート処理を行う

### startScan: function(success, fail)
スキャンの開始を行う

### stopScan: function(requestToken,secretKey,success, fail)
スキャンの停止を行う

### getDeviceIdentifier: function(success, fail)
デバイスID(UUID)を取得する

###    setAdditionalLog: function(logValue,success, fail)
アディショナルログをセットする


### customLog: function(logValue,success, fail) {
カスタムログを送信する

### setShouldUpdateEventListner: function(success, fail, shouldUpdateEventListner)
イベントのアップデートを行うかどうかを指定する。
shouldUpdateEventListner に文字列で "ALWAYS_YES"を指定すれば常にアップデートを実施。
それ以外の場合は、更新があった場合のみ、アップデートを実施。

### setUpdateEventListner: function(updateEventListner, fail)
イベントの更新が完了した場合に呼ばれるコールバック。

### setFireEventListner: function(fireEventListner, fail)
イベントが発火した場合に呼ばれる

## 呼び出しのサンプル
```js
document.addEventListener("deviceready", onDeviceReady, false);
function onDeviceReady() {
  //イベント更新が完了した際に呼ばれるコールバックを登録
  beacappSDK.setUpdateEventListner(function(didFinish){
    // setUpdateEventListner イベント更新完了コールバック
    //スキャンを開始する
    beacappSDK.startScan(function(success){
      // startScan 成功時のコールバック
    },function(error){
      // startScan 失敗時のコールバック
    });
  },function(error){
    // setUpdateEventListner 失敗時のコールバック関数
  });

  //Beacon検知時のコールバックを登録する
  beacappSDK.setFireEventListner(function(fire){
      //イベント発火時のコールバック
      alert(JSON.stringify(fire));
    },function(error){
      //登録に失敗した際のコールバック
    });
  //beacappSDKの初期化
  beacappSDK.initialize("AccessToken","SecretKey",
    function(success){
      //初期化成功のコールバック

      //イベントの更新処理を呼び出す
      beacappSDK.startUpdateEvents(null,null);
    },function(error){
      //初期化失敗時のコールバック
      alert(JSON.stringify(error));
    });
}
```
