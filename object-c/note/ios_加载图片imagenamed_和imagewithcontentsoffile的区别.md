## iOS 加载图片imageNamed 和imageWithContentsOfFile的区别


** imageNamed **
	
	[UIImage imageNamed:@""];
	
会自己识别到底该加二倍图或者是三倍图。

** imageWithContentsOfFile **
	
	[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:@""]];
	
这里的file 所添加的必须是完整的路径，包含了@2x，和@3x。