### 在Webview 中限制电话号码

webapp在iOS的浏览器或者UIWebview中，一串数字（或者中间有短横线 '-'）的都会被识别为电话号码（蓝色超链接的样式）。比如12345，2014-07-02

解决方法：
在html中的 <head></head> 之间加上 <meta name="format-detection" content="telephone=no" />