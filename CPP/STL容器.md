# STRING

### 1. std::string是basic_string<char>的特化版本，string是basic_string<char>的别名,C++ 标准库还提供了其他字符类型的字符串类，例如 std::wstring 用于 wchar_t 类型的字符串。

### 2. 一般来讲，在string非空时begin()指向容器的首元素，end()指向'\0'。

### 3. string的内存布局大致如下：
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/ff9904ee-0c1f-4240-9ec2-00528d627cd2)


### 4. string实现了重载的[]运算符，可以像数组一样访问string的元素。

### 5. string和C字符串的区别：
#### 5.1 string支持拼接操作(重载了运算符'+'、'+=')，C字符串不支持。
#### 5.2 string支持查找(find(),rfind())，C字符串不支持。

# VECTOR

### 1. vector是C++ STL中的一个数据结构，它是一个能够存放任意类型的动态数组，并且能够根据需要自动增长容量。

### 2. vector的内存布局大致如下：
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/000a4bba-ce68-4319-8d75-2538b75d4b30)

### 3. 由于vector底层由动态数组实现，所以它具有以下特性：
#### 3.1 数组中存放元素的指针指向一段连续的内存空间，所以能够使用data()成员函数获取这段空间的起始地址。
#### 3.2 在vector中在尾部插入删除具有较高效率，因为不需要移动元素。
#### 3.3 由于vector的元素是连续存放的，所以支持随机访问，同样也支持使用下标访问元素。

### 4. vector容器的大小
#### 4.1 size()返回的是当前vector中元素的个数。
#### 4.2 capacity()返回的是当前vector底层数组能够容纳的元素大小。
#### 4.3 max_size()表示在系统中vector最大上限，它一般受系统和编译器的限制。
#### 4.4 reserve()和resize()都是用来设置当前vector的容量大小。一般reserve()用于预设容量大小。resize()设置容量大小和初始化元素，若当前大小大于预设值则减小容器否则扩大并已初始值初始化。

