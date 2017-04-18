package jp.co.jmas;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;

import android.content.pm.PackageManager;
import android.os.Build;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.os.AsyncTask;

import com.beacapp.FireEventListener;
import com.beacapp.JBCPException;
import com.beacapp.JBCPManager;
import com.beacapp.ShouldUpdateEventsListener;
import com.beacapp.UpdateEventsListener;

import java.util.Map;
import android.Manifest;

/**
 * This class echoes a string called from JavaScript.
 */
public class BeacappSDK extends CordovaPlugin {
    private BeaconInitTask beaconInitTask = null;
    private boolean updateFlag;
    private JBCPManager jbcpManager;
    private CallbackContext fireEventsContext;
    private CallbackContext updateEventsContext;
    private CallbackContext initializeContext;

    private static final String INITIALIZE = "initialize";
    private static final String START_UPDATE_EVENTS = "startUpdateEvents";
    private static final String START_SCAN = "startScan";
    private static final String STOP_SCAN = "stopScan";
    private static final String GET_DEVICE_IDENTIFIER = "getDeviceIdentifier";
    private static final String SET_ADDITIONAL_LOG = "setAdditionalLog";
    private static final String CUSTOM_LOG = "customLog";
    private static final String SET_SHOULD_UPDATE_EVENT_LISTNER = "setShouldUpdateEventListner";
    private static final String SET_UPDATE_EVENT_LISTNER = "setUpdateEventListner";
    private static final String SET_FIRE_EVENT_LISTNER = "setFireEventListner";

    private static final int REQUEST_CODE_ENABLE_PERMISSION = 88008800;

    private String _requestToken;
    private String _secretKey;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals(INITIALIZE)) {
            String requestToken = args.getString(0);
            String secretKey = args.getString(1);
            initializeContext = callbackContext;
            initialize(requestToken,secretKey);

        } else if (action.equals(START_UPDATE_EVENTS)) {                
            PluginResult result = null;
            if (jbcpManager!=null){
                jbcpManager.startUpdateEvents();
                result = new PluginResult(PluginResult.Status.OK, "success");
            } else{
                result = new PluginResult(PluginResult.Status.ERROR, "error");
            }
            callbackContext.sendPluginResult(result);

        } else if (action.equals(START_SCAN)) {
            PluginResult result = null;
            if (jbcpManager!=null){
                try{
                    jbcpManager.startScan();
                    result = new PluginResult(PluginResult.Status.OK, "success");
                } catch (JBCPException e) {
                    result = new PluginResult(PluginResult.Status.ERROR, "error");
                }
            } else{
                result = new PluginResult(PluginResult.Status.ERROR, "error");
            }
            callbackContext.sendPluginResult(result);

        } else if (action.equals(STOP_SCAN)) {
            PluginResult result = null;
            if (jbcpManager!=null){
                try{
                    jbcpManager.stopScan();
                    result = new PluginResult(PluginResult.Status.OK, "success");
                } catch (JBCPException e) {
                    result = new PluginResult(PluginResult.Status.ERROR, "error");
                }
            } else{
                result = new PluginResult(PluginResult.Status.ERROR, "error");
            }
            callbackContext.sendPluginResult(result);

        } else if (action.equals(GET_DEVICE_IDENTIFIER)) {
            if (jbcpManager!=null){
                PluginResult result = null;
                try {
                    jbcpManager.stopScan();
                    String deviceIdentifier = jbcpManager.getDeviceIdentifier();
                    JSONObject obj = new JSONObject();
                    obj.put("callback", "success");
                    obj.put("deviceIdentifier", deviceIdentifier);
                    result = new PluginResult(PluginResult.Status.OK, obj);
                } catch (Exception e) {
                    result = new PluginResult(PluginResult.Status.ERROR, "error");
                }
                callbackContext.sendPluginResult(result);
            }


        } else if (action.equals(SET_ADDITIONAL_LOG)) {
            PluginResult result = null;
            if (jbcpManager!=null){
                String logValue = args.getString(0);
                try{
                    jbcpManager.setAdditonalLog(logValue);
                    result = new PluginResult(PluginResult.Status.OK, "success");
                } catch (JBCPException e) {
                    result = new PluginResult(PluginResult.Status.ERROR, "error");
                }
            } else{
                result = new PluginResult(PluginResult.Status.ERROR, "error");
            }
            callbackContext.sendPluginResult(result);

        } else if (action.equals(CUSTOM_LOG)) {
            if (jbcpManager!=null){
                String logValue = args.getString(0);
                PluginResult result = null;
                try {
                    jbcpManager.customLog(logValue);
                    result = new PluginResult(PluginResult.Status.OK, "success");
                } catch (Exception e) {
                    result = new PluginResult(PluginResult.Status.ERROR, e.getMessage());
                }
                callbackContext.sendPluginResult(result);

            }

        } else if (action.equals(SET_SHOULD_UPDATE_EVENT_LISTNER)) {
            String updateEvent = args.getString(0);
            if (updateEvent.equals("ALWAYS_YES")){
                updateFlag = true;
            }

        } else if (action.equals(SET_UPDATE_EVENT_LISTNER)) {
            updateEventsContext = callbackContext;

        } else if (action.equals(SET_FIRE_EVENT_LISTNER)) {
            fireEventsContext = callbackContext;
        }

        return true;
    }

    private void initialize(String requestToken, String secretKey){
        _requestToken = requestToken;
        _secretKey = secretKey;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            String[] permissions = {
                    Manifest.permission.ACCESS_COARSE_LOCATION,
                    Manifest.permission.ACCESS_FINE_LOCATION,
                    Manifest.permission.BLUETOOTH,
                    Manifest.permission.BLUETOOTH_ADMIN,
            };
            try {
                if (hasAllPermissions(permissions)) {
                    activate();
                } else {
                    cordova.requestPermissions(this, REQUEST_CODE_ENABLE_PERMISSION, permissions);
                }
            } catch (JSONException e){

            }
        } else {
            activate();
        }
    }

    private boolean hasAllPermissions(String[] permissions) throws JSONException {

        for (int i = 0; i < permissions.length; i++){
            String permission = permissions[i];
            if(!cordova.hasPermission(permission)) {
                return false;
            }
        }
        return true;
    }

    @Override
    public void onRequestPermissionResult(int requestCode, String[] permissions, int[] grantResults) throws JSONException {
        if (permissions != null && permissions.length > 0) {
            //Call hasPermission again to verify
            boolean hasAllPermissions = hasAllPermissions(permissions);
            if (hasAllPermissions){
                activate();
            }
        }
    }

    private void activate(){
        Context context = this.cordova.getActivity().getApplicationContext();
        beaconInitTask = new BeaconInitTask(context) {
            @Override
            protected void onPostExecute(Result result) {
                final int resultCode = result.getCode();
                String resultMessage = result.getMessage();
                if (resultCode == 100) {
                    jbcpManager = getJbcpManager();
                    jbcpManager.setUpdateEventsListener(updateEventsListener);
                    jbcpManager.setFireEventListener(fireEventListener);
                    jbcpManager.setShouldUpdateEventsListener(shouldUpdateEventsListener);

                    PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, resultMessage);
                    initializeContext.sendPluginResult(pluginResult);
                } else {
                    PluginResult pluginResult = new PluginResult(PluginResult.Status.ERROR, resultCode);
                    initializeContext.sendPluginResult(pluginResult);
                }
            }
        };
        beaconInitTask.execute(_requestToken,_secretKey);

    }


    private UpdateEventsListener updateEventsListener = new UpdateEventsListener() {
        @Override
        public void onProgress(int i, int i1) {
        }

        @Override
        public void onFinished(JBCPException e) {
            if (updateEventsContext!=null){
                PluginResult result = new PluginResult(PluginResult.Status.OK, "OK");
                result.setKeepCallback(true);
                updateEventsContext.sendPluginResult(result);
            }
        }
    };


    private ShouldUpdateEventsListener shouldUpdateEventsListener = new ShouldUpdateEventsListener() {
        @Override
        public boolean shouldUpdate(Map<String, Object> map) {
            Boolean alreadyNewest = (Boolean) map.get("alreadyNewest");
            if(updateFlag || !alreadyNewest){
                return true;
            } else{
                return false;
            }
        }
    };

    private FireEventListener fireEventListener = new FireEventListener() {
        @Override
        public void fireEvent(JSONObject event) {
            if (fireEventsContext !=null){
                PluginResult result = new PluginResult(PluginResult.Status.OK, event);
                result.setKeepCallback(true);
                fireEventsContext.sendPluginResult(result);
            }
        }
    };
}

class BeaconInitTask extends AsyncTask<String, Void, BeaconInitTask.Result> {

    private static final String TAG = BeaconInitTask.class.getSimpleName();

    private Context context;

    private JBCPManager jbcpManager;

    public BeaconInitTask(Context context) {
        this.context = context;
    }

    @Override

    protected Result doInBackground(String... params) {
        Result result = new Result();
        try {
            String requestToken = params[0];
            String secretKey = params[1];
            jbcpManager = JBCPManager.getManager(context, requestToken, secretKey, null);
            result.setCode(100);
        } catch (JBCPException e) {
            result.setCode(e.getCode());
            result.setMessage(e.getMessage());
        }
        return result;
    }

    public class Result {
        private String message;
        private int code;

        public void setCode(int code) {
            this.code = code;
        }

        public void setMessage(String message) {
            this.message = message;
        }

        public int getCode() {
            return code;
        }

        public String getMessage() {
            return message;
        }
    }

    public JBCPManager getJbcpManager() {
        return jbcpManager;
    }
}

