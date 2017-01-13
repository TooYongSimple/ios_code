## 修改textField的placeholder的颜色值

#### 1:在xib中设置
> 只需添加 placeholderLabel.textColor 的属性值就可以了

![如图所示](http://7xrn7f.com1.z0.glb.clouddn.com/16-4-25/84482492.jpg)


[这是图片](http://7xrn7f.com1.z0.glb.clouddn.com/16-4-25/84482492.jpg)

#### 2：在代码中设置

	[TextField setValue:[UIColor colorWithRed:98.0/255.0 green:98.0/255.0 blue:98.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];