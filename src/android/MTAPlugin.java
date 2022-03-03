package com.custom.MTAPlugin.MTAPlugin;

import android.text.TextUtils;
import android.util.Log;

import com.tencent.stat.MtaSDkException;
import com.tencent.stat.StatConfig;
import com.tencent.stat.StatService;

import org.apache.cordova.BuildConfig;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Iterator;
import java.util.Properties;

/**
 * Created by AndyZhang on 2018/6/21.
 */

public class MTAPlugin extends CordovaPlugin {
    private static final String ACTION_PAGE_BEGIN = "trackPageViewBegin";
    private static final String ACTION_PAGE_END = "trackPageViewEnd";
    private static final String ACTION_CUSTOM = "trackCustomKeyValueEventWithEventIdAndKvs";
    private static final String ACTION_START = "startWithAppKeyAndCheckedVersion";
    private static final String ACTION_CUSTOM__BEGIN = "trackCustomKeyValueEventBeginWithEventIdAndKvs";
    private static final String ACTION_CUSTOM__END = "trackCustomKeyValueEventEndWithEventIdAndKvs";
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext)
            throws JSONException {
        if (TextUtils.isEmpty(action)) {
            return false;
        }
        if (TextUtils.equals(ACTION_START, action)) {
            //MTA.startMTA('AKLCQ591FK5H');

            StatConfig.setMaxDaySessionNumbers (Integer.MAX_VALUE);
            StatConfig.setEnableConcurrentProcess(true);
            StatConfig.setMaxSendRetryCount(999);
            StatConfig.setMaxBatchReportCount(999);
            StatConfig.setMaxStoreEventCount(499999);
            StatConfig.setMaxDaySessionNumbers(Integer.MAX_VALUE);
            StatConfig.setDebugEnable(BuildConfig.DEBUG);
            String appkey = args.getString(0);
            String version;
            if (args.isNull(1)) {
                version = com.tencent.stat.common.StatConstants.VERSION;
            } else {
                version = args.getString(1);
            }
            try {
                Log.d("MTA", "MTA初始化开始:" + version);
                StatService.startStatService(cordova.getActivity(), appkey, version);
            } catch (MtaSDkException e) {
                Log.d("MTA", "MTA初始化失败" + e);
                e.printStackTrace();
            }
        } else if (TextUtils.equals(ACTION_PAGE_BEGIN, action)) {
            //MTA.trackPageViewBegin('Wechat2');
            String pageName = args.getString(0);
            Log.d("MTA", "页面统计开始:" + pageName);
            StatService.trackBeginPage(cordova.getActivity(), pageName);
        } else if (TextUtils.equals(ACTION_PAGE_END, action)) {
           //  MTA.trackPageViewEnd('Wechat2');
            String pageName = args.getString(0);
            Log.d("MTA", "页面统计结束:" + pageName);
            StatService.trackEndPage(cordova.getActivity(), pageName);
        } else if (TextUtils.equals(ACTION_CUSTOM, action)) {
        // MTA.trackCustomKeyValueEventWithEventIdAndKvs('delData',{“name”:”zhangsan”,”email”:”xxxx@qq.com”,”age”:”20”})
            try {
                String eventId = args.getString(0);
                Properties prop = getProperties(args);

                StatService.trackCustomKVEvent(cordova.getActivity(), eventId, prop);
                callbackContext.success();
            } catch (Exception ex) {
                callbackContext.error(ex.getMessage());
            }

        }
        else if (TextUtils.equals(ACTION_CUSTOM__BEGIN,action)){
            try {
                String eventId = args.getString(0);
                Properties prop = getProperties(args);

                StatService.trackCustomBeginKVEvent(cordova.getActivity(), eventId, prop);
                callbackContext.success();
            } catch (Exception ex) {
                ex.printStackTrace();
                callbackContext.error(ex.getMessage());
            }
        }

        else if (TextUtils.equals(ACTION_CUSTOM__END,action)){
            try {
                String eventId = args.getString(0);
                Properties prop = getProperties(args);
                StatService.trackCustomEndKVEvent(cordova.getActivity(), eventId, prop);
                callbackContext.success();
            } catch (Exception ex) {
                ex.printStackTrace();
                callbackContext.error(ex.getMessage());
            }
        }

        else {
            Log.d("MTA", "刷新：:" + action); 
            StatService.commitEvents(cordova.getActivity(),-1);
        }
        return true;
    }

    private Properties getProperties(JSONArray args) throws JSONException {
        JSONObject jsonObject = new JSONObject(args.getString(1));
        Properties prop = new Properties();
        Iterator<String> keys = jsonObject.keys();

        while (keys.hasNext()){
            String key= keys.next();
            String value = jsonObject.getString(key);
            prop.setProperty(key, value);
            Log.d("MTA","自定义事件:key="+key+",value="+value);
        }
        return prop;
    }

}
