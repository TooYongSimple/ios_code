# 用pod安装UMengSDK之后使用SVN上传其他位置报错

## 解决
	svn 默认 ignore（忽略）一些文件，例如 “*.o”，怎么取消这种默认忽略让文件能正常提交呢？
	切换到指定目录，使用 “svn add * --force --no-ignore” 命令即可。
	其中，“--no-ignore” 是取消忽略，“* --force” 是添加当前目录及所有子目录下的所有文件。