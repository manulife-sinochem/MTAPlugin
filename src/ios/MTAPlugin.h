//
//  MTAPlugin.h
//  HelloCordova
//
//  Created by manulife on 2018/6/22.
//

#import "AppDelegate.h"

@interface MTAPlugin : CDVPlugin

#pragma mark - 启动MTA
/*
//启动MEA

@param appkey 从网页申请的appKey
@param ver 最低允许启动的版本(可选)
 */
- (void)startWithAppKeyAndCheckedVersion:(CDVInvokedUrlCommand *)command;

#pragma mark - 统计页面时长
/**
 标记一次页面访问的开始
 此接口需要跟trackPageViewEnd配对使用
 多次开始以第一次开始的时间为准
 @param page 页面名
 */
- (void)trackPageViewBegin:(CDVInvokedUrlCommand *)command;


/**
 标记一起页面访问的开始
 并且指定上报方式
 此接口需要跟trackPageViewEnd配对使用
 多次开始以第一次开始的时间为准

 @param page 页面名
 @param appkey 若此参数不为nil，则上报到此appkey。否则，上报到startWithAppkey中传入的appkey
 */
- (void)trackPageViewBeginWithPageAndAppkey:(CDVInvokedUrlCommand *)command;


/**
 标记一次页面访问的结束
 此接口需要跟trackPageViewBegin配对使用
 多次结束以第一次结束的时间为准

 @param page 页面名字
 */
- (void)trackPageViewEnd:(CDVInvokedUrlCommand *)command;

/**
 标记一起页面访问的结束
 并且指定上报方式
 此接口需要跟trackPageViewBegin配对使用
 多次结束以第一次结束的时间为准

 @param page 页面名
 @param appkey 若此参数不为nil，则上报到此appkey。否则，上报到startWithAppkey中传入的appkey
 @param isRealTime 是否实时上报，若传入YES，则忽略全局上报策略实时上报。否则按照全局策略上报。
 */
- (void)trackPageViewEndWithPageAppkeyAndIsRealTime:(CDVInvokedUrlCommand *)command;



#pragma mark - 自定义事件

#pragma mark - 简单介绍
/**
 自定义事件分为两类
 1. 次数统计
 2. 时长统计
 两类自定义事件都可以带 NSDictionary 类型的参数
 */

#pragma mark - 自定义事件参数长度限制说明
/**
 自定义参数长度上限为60kb，
 计算方法为将参数转换为JSON字符串以后与event_id连接。
 然后判断连接后的字符串是否超过限制。
 */

/**
 上报自定义事件
 @param event_id 事件的ID，ID需要先在MTA前台配置好才能生效
 @param kvs 事件的参数，参数需要先在MTA前台配置好才能生效
 */
- (void)trackCustomKeyValueEventWithEventIdAndKvs:(CDVInvokedUrlCommand *)command;

/**
 上报自定义事件
 并且指定上报方式

 @param event_id 事件的ID，ID需要先在MTA前台配置好才能生效
 @param kvs 事件的参数，参数需要先在MTA前台配置好才能生效
 @param appkey 需要上报的appKey，若传入nil，则上报到启动函数中的appkey
 @param isRealTime 是否实时上报，若传入YES，则忽略全局上报策略实时上报。否则按照全局策略上报。
 */

- (void)trackCustomKeyValueEventWithEventIdKvsAppkeyAndIsRealTime:(CDVInvokedUrlCommand *)command;


/**
 开始统计自定义时长事件
 此接口需要跟trackCustomKeyValueEventEnd配对使用
 多次调用以第一次开始时间为准

 @param event_id 事件的ID，ID需要先在MTA前台配置好才能生效
 @param kvs 事件的参数，参数需要先在MTA前台配置好才能生效
 */

- (void)trackCustomKeyValueEventBeginWithEventIdAndKvs:(CDVInvokedUrlCommand *)command;

/**
 开始统计自定义时长事件并指定上报方式
 此接口需要跟trackCustomKeyValueEventEnd配对使用
 多次调用以第一次开始时间为准

 @param event_id 事件的ID，ID需要先在MTA前台配置好才能生效
 @param kvs 事件的参数，参数需要先在MTA前台配置好才能生效
 @param appkey 需要上报的appKey，若传入nil，则上报到启动函数中的appkey
 */
- (void)trackCustomKeyValueEventBeginWithEventIdKvsAndAppkey:(CDVInvokedUrlCommand *)command;

/**
 结束统计自定义时长事件
 此接口需要跟trackCustomKeyValueEventBegin配对使用
 多次调用以第一次结束时间为准

 @param event_id 事件的ID，ID需要先在MTA前台配置好才能生效
 @param kvs 事件的参数，参数需要先在MTA前台配置好才能生效
 参数中的key和value必须跟开始统计时传入的参数一样才能正常配对
 */

- (void)trackCustomKeyValueEventEndWithEventIdAndKvs:(CDVInvokedUrlCommand *)command;


/**
 结束上报自定义时长事件
 并指定上报方式
 此接口需要跟trackCustomKeyValueEventBegin配对使用
 多次调用以第一次结束时间为准

 @param event_id 事件的ID，ID需要先在MTA前台配置好才能生效
 @param kvs 事件的参数，参数需要先在MTA前台配置好才能生效
 参数中的key和value必须跟开始统计时传入的参数一样才能正常配对
 @param appkey 需要上报的appKey，若传入nil，则上报到启动函数中的appkey
 @param isRealTime 是否实时上报，若传入YES，则忽略全局上报策略实时上报。否则按照全局策略上报。
 */
- (void)trackCustomKeyValueEventEndWithEventIdKvsAppkeyAndIsRealTime:(CDVInvokedUrlCommand *)command;


/**
 直接统计自定义时长事件
 这个方法用于上报统计好的时长事件

 @param seconds 自定义事件的时长，单位秒
 @param event_id 事件的ID，ID需要先在MTA前台配置好才能生效
 @param kvs 事件的参数，参数需要先在MTA前台配置好才能生效
 */
- (void)trackCustomKeyValueEventDurationWithSecondsEventIdAndKvs:(CDVInvokedUrlCommand *)command;

/**
 直接上报自定义时长事件
 并指定上报方式
 这个方法用于上报统计好的时长事件

 @param seconds 自定义事件的时长，单位秒
 @param event_id 事件的ID，ID需要先在MTA前台配置好才能生效
 @param kvs 事件的参数，参数需要先在MTA前台配置好才能生效
 @param appkey 需要上报的appKey，若传入nil，则上报到启动函数中的appkey
 @param isRealTime 是否实时上报，若传入YES，则忽略全局上报策略实时上报。否则按照全局策略上报。
 */
- (void)trackCustomKeyValueEventDurationWithSecondsEventIdKvsAppkeyIsAndRealTime:(CDVInvokedUrlCommand *)command;
/**
 上报当前缓存的数据
 若当前有缓存的事件（比如上报策略不为实时上报，或者有事件上报失败）时
 调用此方法可以上报缓存的事件

 @param maxStatCount 最大上报事件的条数
 */
- (void)commitCachedStatsWithMaxStatCount:(CDVInvokedUrlCommand *)command;


/**
 开始统计使用时长
 建议在App进入前台时调用
 */
- (void)trackActiveBegin:(CDVInvokedUrlCommand *)command;


/**
 结束统计使用时长
 建议在App离开前台时调用
 */
- (void)trackActiveEnd:(CDVInvokedUrlCommand *)command;

@end
