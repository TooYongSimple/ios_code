# Ping ++的使用

## Client SDK

Client SDK 支持 Android 终端、iOS 终端 、手机网页和 PC 网页这四种平台，分别对应 Android、iOS 、 HTML5 和 PC 这四种 Client SDK。使用 Client SDK 调起支付控件完成交易的详细流程参见 Client SDK 接入指南。

## iOS SDK 接入指南
### 安装
使用 CocoaPods

在 Podfile 添加

    pod 'Pingpp', '~> 2.1.0'
默认会包含支付宝、微信、银联和百度钱包，你也可以自己选择渠道。
目前有 ApplePay、Alipay、Wx、UnionPay、Bfb 五个子模块可选择，例如：

    pod 'Pingpp/Alipay', '~> 2.1.0'
    pod 'Pingpp/Wx', '~> 2.1.0'
    pod 'Pingpp/UnionPay', '~> 2.1.0'
    pod 'Pingpp/ApplePay', '~> 2.1.0'

运行 pod install
从现在开始使用 .xcworkspace 打开项目，而不是 .xcodeproj
添加 URL Schemes：在 Xcode 中，选择你的工程设置项，选中 TARGETS 一栏，在 Info 标签栏的 URL Types 添加 URL Schemes，如果使用微信，填入微信平台上注册的应用程序 id（为 wx 开头的字符串），如果不使用微信，则自定义，建议起名稍复杂一些，尽量避免与其他程序冲突。允许英文字母和数字，首字母必须是英文字母，不允许特殊字符。
2.1.0 及以上版本，可打开 Debug 模式，打印出 log，方便调试。开启方法：[Pingpp setDebugMode:YES];。
## 接入
客户端从服务器端拿到 charge 对象后，调用下面的方法

	[Pingpp createPayment:charge
       viewController:viewController
         appURLScheme:kUrlScheme
       withCompletion:^(NSString *result, PingppError *error) {
    if ([result isEqualToString:@"success"]) {
        // 支付成功
    } else {
        // 支付失败或取消
        NSLog(@"Error: code=%lu msg=%@", error.code, [error getMsg]);
    }
	}];
 
接收并处理交易结果
渠道为银联、百度钱包或者渠道为支付宝但未安装支付宝钱包时，交易结果会在调起插件时的 Completion 中返回。渠道为微信、支付宝且安装了支付宝钱包或者测试模式时，请实现 UIApplicationDelegate 的 - application:openURL:xxxx: 方法：

### iOS 8 及以下

	- (BOOL)application:(UIApplication *)application 
            openURL:(NSURL *)url sourceApplication:                                    (NSString *)sourceApplication 
         annotation:(id)annotation {
    BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
    return canHandleURL;
    }

### iOS 9 及以上

	- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url 
            options:(NSDictionary *)options {
    BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
    return canHandleURL;
	}

### 关于渠道
使用微信支付必须要求用户安装微信客户端。

### 适配 iOS 9 注意事项
由于 iOS 9 系统策略更新以及支付渠道的变更，为了更好的支付体验，请下载 iOS-SDK 最新版本。

针对 iOS 9 系统更新， 为了使你接入的微信支付与支付宝支付兼容 iOS 9 ,请按照以下引导进行操作： 应用需要在 Info.plist 中将要使用的 URL Schemes 列为白名单，才可正常检查其他应用是否安装。受此影响，当你使用 Xcode 7 及 iOS 9 编译发布新版本 App，并且用到了判断是否安装相应的 App （支付宝钱包、微信）的接口时，需要在 Info.plist 里添加如下代码：

<key>LSApplicationQueriesSchemes</key>
<array>
    <string>weixin</string>
    <string>wechat</string>
    <string>alipay</string>
</array>
请注意未升级到微信 6.2.5 及以上版本的用户，在 iOS 9 下使用到微信相关功能时，仍可能无法成功。

针对 iOS 9 限制 http 协议的访问，如果 App 需要访问 http://， 则需要在 Info.plist 添加如下代码：

<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
针对使用 Xcode 7 编译失败，遇到错误信息为：

XXXXXXX does not contain bitcode. You must rebuild it with bitcode enabled (Xcode setting ENABLE_BITCODE), obtain an updated library from the vendor, or disable bitcode for this target.

请到 Xcode 项目的 Build Settings 标签页搜索 bitcode，将 Enable Bitcode 设置为 NO 即可。

注意 以上更改项完成后，需使用 Xcode 7 进行编译。