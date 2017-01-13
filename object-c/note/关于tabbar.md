## 关于tabbar

1.首先创建NavigationController 然后将 tabbar 作为navigationController 的根目录的时候，当从 Tabbar 的 item 中 push 出一个新的视图的时候，tabbar 会自动隐藏。

2.当先设置一个 **Tabbar** 然后为**Tabbar**的每一个**item**创建ViewController，并且每一个 VC 都是带**Navigation**的话，从**item**中点击**push**到下一个页面的时候，**Tabbar**不会隐藏。