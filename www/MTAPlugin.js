var exec = require('cordova/exec');
var pluginName = "MTAPlugin"

var MTA = function() {};


/** 
 * 1、start the mta
 *
 * @param {String} appkey               从网页申请的appKey
 * @param {String} ver                  最低允许启动的版本(不限制传空字符串或null)
 * @param {Function} completeCallback   成功回调
 * @param {Function} errorCallback      失败回调
 */
MTA.startMTA = function(appkey, ver, completeCallback, errorCallback) {
    var message = [];
    if (ver != null && ver.length > 0) {
        message = [appkey, ver];
    } else {
        message = [appkey]
    }
    exec(completeCallback, errorCallback, pluginName, "startWithAppKeyAndCheckedVersion", message);
}



/** 
 * 2、标记一次页面访问的开始 此接口需要跟trackPageViewEnd配对使用 多次开始以第一次开始的时间为准
 *
 * @param {String} page  页面名
 * @param {Function} completeCallback   成功回调
 * @param {Function} errorCallback      失败回调
 */
MTA.trackPageViewBegin = function(page, completeCallback, errorCallback) {

    exec(completeCallback, errorCallback, pluginName, "trackPageViewBegin", [page]);
}

/** 
 * 3、标记一次页面访问的开始 此接口需要跟trackPageViewEnd配对使用 多次开始以第一次开始的时间为准
 *
 * @param {String} page  页面名
 * @param {String} appkey  appkey 若此参数不为nil，则上报到此appkey。否则，上报到startWithAppkey中传入的appkey
 * @param {Function} completeCallback   成功回调
 * @param {Function} errorCallback      失败回调
 */
MTA.trackPageViewBeginWithPageAndAppkey = function(page, appkey, completeCallback, errorCallback) {

    var message = [page];
    if (appkey != null) {
        message.push(appkey)
    }

    exec(completeCallback, errorCallback, pluginName, "trackPageViewBeginWithPageAndAppkey", message);
}


/** 
 * 4、标记一次页面访问的结束 此接口需要跟trackPageViewBegin配对使用 多次开始以第一次开始的时间为准
 *
 * @param {String} page  页面名
 * @param {Function} completeCallback   成功回调
 * @param {Function} errorCallback      失败回调
 */
MTA.trackPageViewEnd = function(page, completeCallback, errorCallback) {
    exec(completeCallback, errorCallback, pluginName, "trackPageViewEnd", [page]);
}



/** 
 * 5、标记一起页面访问的结束 此接口需要跟trackPageViewBegin配对使用 多次开始以第一次开始的时间为准
 *
 * @param {String} page  页面名
 * @param {String}  appkey  appkey 若此参数不为nil，则上报到此appkey。否则，上报到startWithAppkey中传入的appkey
 * @param {Boolean} isRealTime  是否实时上报，若传入YES，则忽略全局上报策略实时上报。否则按照全局策略上报。
 * @param {Function} completeCallback   成功回调
 * @param {Function} errorCallback      失败回调
 */
MTA.trackPageViewEndWithPageAppkeyAndIsRealTime = function(page, appkey, isRealTime, completeCallback, errorCallback) {

    var real = false,
        message = [];
    if (isRealTime != null && isRealTime == true) {
        real = true
    }
    message = appkey != null ? [page, appkey, real] : [page, real]

    exec(completeCallback, errorCallback, pluginName, "trackPageViewEndWithPageAppkeyAndIsRealTime", message);
}


/**************************************************************************************************自定义事件**************************************************************************************************/

/** 
 * 6、上报自定义事件
 *
 * @param {String} event_id  事件的ID，ID需要先在MTA前台配置好才能生效
 * @param {jsonObject} kvs   事件的参数，参数需要先在MTA前台配置好才能生效
 * @param {Function} completeCallback   成功回调
 * @param {Function} errorCallback      失败回调
 */

MTA.trackCustomKeyValueEventWithEventIdAndKvs = function(event_id, kvs, completeCallback, errorCallback) {
    var options = kvs;
    if (kvs == null) {
        options = {}
    }
    exec(completeCallback, errorCallback, pluginName, "trackCustomKeyValueEventWithEventIdAndKvs", [event_id, options]);
}


/** 
 * 7、上报自定义事件  并且指定上报方式
 *
 * @param {String} event_id      事件的ID，ID需要先在MTA前台配置好才能生效
 * @param {jsonObject} kvs       事件的参数，参数需要先在MTA前台配置好才能生效
 * @param {String} appkey        需要上报的appKey，若传入nil，则上报到启动函数中的appkey
 * @param {Boolean} isRealTime   是否实时上报，若传入YES，则忽略全局上报策略实时上报。否则按照全局策略上报。
 * @param {Function} completeCallback   成功回调
 * @param {Function} errorCallback      失败回调
 */

MTA.trackCustomKeyValueEventWithEventIdKvsAppkeyAndIsRealTime = function(event_id, kvs, appkey, isRealTime, completeCallback, errorCallback) {

    var options = kvs,
        real = false,
        message = [];
    if (kvs == null) {
        options = {}
    }

    if (isRealTime != null && isRealTime == true) {
        real = true
    }

    message = appkey != null ? [event_id, options, appkey, real] : [event_id, options, real];

    exec(completeCallback, errorCallback, pluginName, "trackCustomKeyValueEventWithEventIdKvsAppkeyAndIsRealTime", message);
}


/** 
 * 8、 开始统计自定义时长事件 此接口需要跟trackCustomKeyValueEventEnd配对使用 多次调用以第一次开始时间为准
 *
 * @param {String} event_id  事件的ID，ID需要先在MTA前台配置好才能生效
 * @param {jsonObject} kvs   事件的参数，参数需要先在MTA前台配置好才能生效
 * @param {Function} completeCallback   成功回调
 * @param {Function} errorCallback      失败回调
 */

MTA.trackCustomKeyValueEventBeginWithEventIdAndKvs = function(event_id, kvs, completeCallback, errorCallback) {
    var options = kvs;
    if (kvs == null) {
        options = {}
    }
    exec(completeCallback, errorCallback, pluginName, "trackCustomKeyValueEventBeginWithEventIdAndKvs", [event_id, options]);
}



/** 
 * 9、 开始统计自定义时长事件并指定上报方式 此接口需要跟trackCustomKeyValueEventEnd配对使用 多次调用以第一次开始时间为准
 *
 * @param {String} event_id      事件的ID，ID需要先在MTA前台配置好才能生效
 * @param {jsonObject} kvs       事件的参数，参数需要先在MTA前台配置好才能生效
 * @param {String} appkey        需要上报的appKey，若传入nil，则上报到启动函数中的appkey
 * @param {Function} completeCallback   成功回调
 * @param {Function} errorCallback      失败回调
 */

MTA.trackCustomKeyValueEventBeginWithEventIdKvsAndAppkey = function(event_id, kvs, appkey, completeCallback, errorCallback) {

    var options = kvs,
        message = [];
    if (kvs == null) {
        options = {}
    }

    message = appkey != null ? [event_id, options, appkey] : [event_id, kvs]

    exec(completeCallback, errorCallback, pluginName, "trackCustomKeyValueEventBeginWithEventIdKvsAndAppkey", message);
}




/** 
 * 10、 结束统计自定义时长事件 此接口需要跟trackCustomKeyValueEventBegin配对使用 多次调用以第一次结束时间为准
 *
 * @param {String} event_id      事件的ID，ID需要先在MTA前台配置好才能生效
 * @param {jsonObject} kvs       事件的参数，参数需要先在MTA前台配置好才能生效 参数中的key和value必须跟开始统计时传入的参数一样才能正常配对
 * @param {Function} completeCallback   成功回调
 * @param {Function} errorCallback      失败回调
 */

MTA.trackCustomKeyValueEventEndWithEventIdAndKvs = function(event_id, kvs, completeCallback, errorCallback) {

    var options = kvs;
    if (kvs == null) {
        options = {}
    }
    exec(completeCallback, errorCallback, pluginName, "trackCustomKeyValueEventEndWithEventIdAndKvs", [event_id, options]);
}

/** 
 * 11、 结束统计自定义时长事件  并指定上报方式 此接口需要跟trackCustomKeyValueEventBegin配对使用 多次调用以第一次结束时间为准
 *
 * @param {String} event_id      事件的ID，ID需要先在MTA前台配置好才能生效
 * @param {jsonObject} kvs       事件的参数，参数需要先在MTA前台配置好才能生效 参数中的key和value必须跟开始统计时传入的参数一样才能正常配对
 * @param {String} appkey        需要上报的appKey，若传入nil，则上报到启动函数中的appkey
 * @param {Boolean} isRealTime   是否实时上报，若传入YES，则忽略全局上报策略实时上报。否则按照全局策略上报。
 * @param {Function} completeCallback   成功回调
 * @param {Function} errorCallback      失败回调
 */
MTA.trackCustomKeyValueEventEndWithEventIdKvsAppkeyAndIsRealTime = function(event_id, kvs, appkey, isRealTime, completeCallback, errorCallback) {

    var options = kvs,
        real = false,
        message = [];
    if (kvs == null) {
        options = {}
    }
    if (isRealTime != null && isRealTime == true) {
        real = true
    }

    message = appkey != null ? [event_id, options, appkey, real] : [event_id, options, real];

    exec(completeCallback, errorCallback, pluginName, "trackCustomKeyValueEventEndWithEventIdKvsAppkeyAndIsRealTime", message);
}


/** 
 * 12、 直接上报自定义时长事件  这个方法用于上报统计好的时长事件
 *
 * @param {float} seconds      自定义事件的时长，单位秒
 * @param {String} event_id     事件的ID，ID需要先在MTA前台配置好才能生效
 * @param {jsonObject} kvs      事件的参数，参数需要先在MTA前台配置好才能生效
 * @param {Function} completeCallback   成功回调
 * @param {Function} errorCallback      失败回调
 */

MTA.trackCustomKeyValueEventDurationWithSecondsEventIdAndKvs = function(seconds, event_id, kvs, completeCallback, errorCallback) {

    var options = kvs

    if (kvs == null) {
        options = {}
    }
    exec(completeCallback, errorCallback, pluginName, "trackCustomKeyValueEventDurationWithSecondsEventIdAndKvs", [seconds, event_id, options]);
}


/** 
 * 13、 直接上报自定义时长事件 并指定上报方式 这个方法用于上报统计好的时长事件
 *
 * @param {float} seconds        自定义事件的时长，单位秒
 * @param {String} event_id      事件的ID，ID需要先在MTA前台配置好才能生效
 * @param {jsonObject} kvs       事件的参数，参数需要先在MTA前台配置好才能生效
 * @param {String} appkey        需要上报的appKey，若传入nil，则上报到启动函数中的appkey
 * @param {Boolean} isRealTime   是否实时上报，若传入YES，则忽略全局上报策略实时上报。否则按照全局策略上报。
 * @param {Function} completeCallback   成功回调
 * @param {Function} errorCallback      失败回调
 */

MTA.trackCustomKeyValueEventDurationWithSecondsEventIdKvsAppkeyIsAndRealTime = function(seconds, event_id, kvs, appkey, isRealTime, completeCallback, errorCallback) {

    var options = kvs,
        message = [],
        real = false;

    if (kvs == null) {
        options = {}
    }

    if (isRealTime != null && isRealTime == true) {
        real = true
    }
    message = appkey != null ? [seconds, event_id, options, appkey, real] : [seconds, event_id, options, real]

    exec(completeCallback, errorCallback, pluginName, "trackCustomKeyValueEventDurationWithSecondsEventIdKvsAppkeyIsAndRealTime", message);
}


/** 
 * 14、 上报当前缓存的数据 若当前有缓存的事件（比如上报策略不为实时上报，或者有事件上报失败）时   调用此方法可以上报缓存的事件
 *
 * @param {Int} maxStatCount            最大上报事件的条数
 * @param {Function} completeCallback   成功回调
 * @param {Function} errorCallback      失败回调
 */
MTA.commitCachedStatsWithMaxStatCount = function(maxStatCount, completeCallback, errorCallback) {

    exec(completeCallback, errorCallback, pluginName, "commitCachedStatsWithMaxStatCount", [maxStatCount]);
}

/** 

 15、 开始统计使用时长
 建议在App进入前台时调用
 */

MTA.trackActiveBegin = function(completeCallback, errorCallback) {
    exec(completeCallback, errorCallback, pluginName, "trackActiveBegin", []);
}

/**
 16、 结束统计使用时长
 建议在App离开前台时调用
 */

MTA.trackActiveEnd = function(completeCallback, errorCallback) {
    exec(completeCallback, errorCallback, pluginName, "trackActiveEnd", []);
}


module.exports = MTA