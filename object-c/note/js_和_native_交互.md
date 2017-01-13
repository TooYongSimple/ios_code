## js 和 native 交互


#### js 调用 native
1. js 中点击加入购物车按钮，本地需要进行网络请求来讲商品保存到本地的数据库中。
2. 进行操作之后，js 会接着走自己的方法，从而改变webview的状态，实现js 调用native方法

#### native 调用 js
 1. native 会传一个值到js中，从而执行js 的代码，然后改变webview 的状态，刷新webview的状态
 