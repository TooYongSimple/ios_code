## Python 学习

 1. **raw_input()** 输入函数；
 2. **ord('A')** 可以把字符转成对应的**ASCLL**
 3. **chr(65)** 可以把数字转换为ASCLL对应的字符
 
### 使用list和tuple
 
 
 1. **[-1]** 表示数组中最后的一个元素
 2. **classmates.append('Adam')** 追加一个元素
 3. **classmates.insert(1, 'Jack')** 添加到指定位置
 4. **classmates.pop()** 删除末尾元素
 5. **classmates.pop(1)** 删除指定位置元素
 6. **list** 是可变的
 7. **tuple** 是不可变的
 
### 条件判断和循环
1. if
2. if elif
3. if else
4. for ... in
5. while
6. **range()**  生成一个整数数列

### 使用dict和set
1. dict['']来获取key对应的值
2. dict.get('xxx')来获取对应的值，如果不存在key会返回none
3. dict.get('xxx', -1)如果不存在key 就会返回一个 -1
4. dict.pop('Bob')删除一个key
5. **set** 值不会重复
6. a.sort()排序函数
7. a.replace('a', 'A') 将a替换成A

### 调用函数
1. abs(20) 返回一个正数
2. cmp(1，2) 返回比较的结果
3. a = abs  函数的别名

### 定义函数
1. 使用**def**
2. **def power(x, n=2)**可以为参数设置默认值，如果没有输入n的值也可以计算出函数的值
3. **使用 from abstest import my_abs** 来导入 **my_abs（）**函数：从abstest.py 文件中，引用了 my_abs 函数，这样 这个函数就可以直接调用了。
4. 		def nop():

			pass
	这是一个空函数，包含了pass 能保证程序可以运行起来。
5. 返回多个值,会返回一个元组