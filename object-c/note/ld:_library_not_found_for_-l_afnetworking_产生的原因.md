## ld: library not found for -l AFNetworking 产生的原因

1. 没有用workspace 打开项目

2. Project -> Pods 里面的 “Build Active Architecture Only” 没有设置成 “NO”

3. 在 Other Linker Flags 中加个-l"AFNetworking"

4. 点击 XCode 工程文件，在 Build Phases 中查看 “ Link binary With Libraries”  如果不出所料，你应该能发现有一到数个的条目是用红色字体来显示的。 
说明这些被工程引用的这些文件，其物理文件已经不处于之前所记录的地方了.这种情况下，右键点击红色条目，选择 “Reveal in Project Navigator”,此时大抵能在左侧栏中定位到缺失文件所在的路径，接下来就好办了，找到缺失的文件，挪回它应该待的地方。

5. 在工程的 Target 中选中要执行编译的某个target， 然后 “get info”，打开 Build 设置页面，在 “ Library Search Path” 中添加缺失链接库的所在文件夹的路径。

    本来看到这两种方法时觉得第一种应该就能解决了，因为报错的信息看起来就像是原来的文件引用不到了而已，但是当我按照第一种方法去做时，发现“ Link binary With Libraries” 下没有红色的条目，而且本来就没有AFNetworking这个条目，所以第一种方法不适用。第二种方法也不对，因为我们的项目很多库是通过pod管理的，AFNetworking也是pod管理的库之一。这时候我就想起可能是pod的原因，在尝试了pod update无果后，发现了第三种解决类似问题的方法。
    
6. 关闭Xcode，在控制台打开到工程目录，用pod install 命令重新安装，成功后再打开Xcode编译项目。

    最后，第三种方法解决了我遇到的问题。但是为什么为出现这种错误呢？以前遇到需要类库有版本升级、类库有删减，使用pod update命令就可以了，而需要重新pod install的情况很少。我又对比了更新前后两个版本的Podfile，发现也没有不同，也就是说问题不是由于Podfile变化引起的。


7. 最后的解决方法：

	'在Other Linker Flags 中删除 -l"AFNetworking"'
    '在 header search path 中把那行给删了'
	
   



