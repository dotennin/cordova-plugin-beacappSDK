module.exports = {
    //BeacappSDKの初期化を行う
    initialize: function(requestToken,secretKey,success, fail) {
        cordova.exec(success, fail, "beacappSDK","initialize", [requestToken,secretKey]);
    },
    //イベントのアップデート処理を行う
    startUpdateEvents: function(success, fail) {
        cordova.exec(success, fail, "beacappSDK","startUpdateEvents", []);
    },
    //スキャンの開始を行う
    startScan: function(success, fail) {
        cordova.exec(success, fail, "beacappSDK","startScan", []);
    },
    //スキャンの停止を行う
    stopScan: function(requestToken,secretKey,success, fail) {
        cordova.exec(success, fail, "beacappSDK","stopScan", []);
    },
    //デバイスID(UUID)を取得する
    getDeviceIdentifier: function(success, fail) {
        cordova.exec(success, fail, "beacappSDK","getDeviceIdentifier", []);
    },
    //アディショナルログをセットする
    setAdditionalLog: function(logValue,success, fail) {
        cordova.exec(success, fail, "beacappSDK","setAdditionalLog", [logValue]);
    },
    //カスタムログを送信する
    customLog: function(logValue,success, fail) {
        cordova.exec(success, fail, "beacappSDK","customLog", [logValue]);
    },
    //イベントのアップデートを行うかどうかを指定する。
    //shouldUpdateEventListner に文字列で "ALWAYS_YES"を指定すれば常にアップデートを実施。
    //それ以外の場合は、更新があった場合のみ、アップデートを実施。
    setShouldUpdateEventListner: function(success, fail, shouldUpdateEventListner) {
        cordova.exec(success, fail, "beacappSDK","setShouldUpdateEventListner", [shouldUpdateEventListner]);
    },
    //イベントの更新が完了した場合に呼ばれるコールバック。
    setUpdateEventListner: function(updateEventListner, fail) {
        cordova.exec(updateEventListner, fail, "beacappSDK","setUpdateEventListner", []);
    },
    //イベントが発火した場合に呼ばれる
    setFireEventListner: function(fireEventListner, fail) {
        cordova.exec(fireEventListner, fail, "beacappSDK","setFireEventListner", []);
    }
  }
