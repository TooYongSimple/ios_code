## Swift 学习笔记

1. UInt 表示的是无符号整形，也就是说只有0和正数
2. Int 表示的是有符号的整形，有0、正数、负数之分
3. 空合运算符 (a ?? b) (如果a有值得话，强制解析，如果没值的话将 b 做为默认值)

### 空合运算符
空合运算符（a ?? b）将对可选类型 a 进行空判断，如果 a 包含一个值就进行解封，否则就返回一个默认值 b。表达式 a 必须是 Optional 类型。默认值 b 的类型必须要和 a 存储值的类型保持一致。
空合运算符是对以下代码的简短表达方法：

	a != nil ? a! : b

### switch 贯穿
	switch some value to consider {
		case value 1,
     	value 2:
    	statements
	}
	
1. 使用的是逗号，而不是 OC 里边的冒号。
2. 还可以使用一个值得区间。

		case 1..<5:
    		naturalCount = "a few"
		case 5..<12:
    		naturalCount = "several"
		case 12..<100:
    		naturalCount = "dozens of"
		case 100..<1000:
    		naturalCount = "hundreds of"

3. 还可以是一个元组

		case (0, 0):
		    print("(0, 0) is at the origin")
		case (_, 0):
		    print("(\(somePoint.0), 0) is on the x-axis")
		case (0, _):
		    print("(0, \(somePoint.1)) is on the y-axis")
		case (-2...2, -2...2):
		

### 隐藏状态栏
1. 重载	prefersStatusBarHidden 方法 **设置成功**
	> override func prefersStatusBarHidden() -> Bool{
        return  true
    }
2. 使用 **UIApplication.sharedApplication().statusBarHidden = true** 方法
	> 亲测，没什么用，不知道哪出问题了
	
	
	
	
	
	
	
