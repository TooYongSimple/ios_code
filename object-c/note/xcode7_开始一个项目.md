## xcode7 开始一个项目

**——————————配置方面———————-**

1:使用cocoaPods添加完库之后一直有警告，在 other linker flags 里增加 -w 就可以了（实际是隐藏了警告而已，并没有真正处理）

2：设置白名单

3：设置bitcode

4：设置可后台访问地理位置

5：LaunchScreen  只能使用在7.1以后


 **—————————程序方面————————**
 
1：设置pch文件；

2：修改appdelegate名字，为程序加前缀；

3：做BaseViewcontroller，设置基本导航条；

4：做 Model 的基类；

5：做UIView、UILabel、UITableViewCell的基类；

6：做UIButton的基类，文字和图片的不同位置；

7：做UIColor的类别；
