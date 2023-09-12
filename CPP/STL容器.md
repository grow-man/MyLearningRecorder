# STRING

### 1. std::string是basic_string<char>的特化版本，string是basic_string<char>的别名,C++ 标准库还提供了其他字符类型的字符串类，例如 std::wstring 用于 wchar_t 类型的字符串。

### 2. 一般来讲，在string非空时begin()指向容器的首元素，end()指向'\0'。

### 3. string的内存布局大致如下：

### 4. string实现了重载的[]运算符，可以像数组一样访问string的元素。

### 5. string和C字符串的区别：
#### 5.1 string支持拼接操作(重载了运算符'+'、'+=')，C字符串不支持。
#### 5.2 string支持查找(find(),rfind())，C字符串不支持。

# VECTOR

