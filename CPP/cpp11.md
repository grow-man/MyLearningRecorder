# nullptr  
作为`NULL`的上位替代，nullptr是一个字面常量(关键字),它的类型是`std::nullptr_t`,可以隐式的转换为任何指针类型.  

# lambda 表达式   
lambda 表达式是 C++11 引入的一项功能，允许在代码中定义匿名函数。它的语法形式为：  
```
[capture-list] (parameters) -> return-type { body }
```
其中：

* capture-list：用于捕获外部变量的列表。可以是空的、值捕获或引用捕获。
* parameters：函数的参数列表。
* return-type：函数的返回类型。可以省略，编译器会根据返回语句自动推导。
* body：函数体，包含函数的实际操作。

重点： capture-list：捕获外部列表，其中值捕获是在内部创建副本，修改副本不会对原始变量产生影响。引用捕获则是在内部生成原变量的引用，改变它会同时修改原变量的值。  
例子：  
```
#include <iostream>

int main() {
    int x = 10;
    int y = 20;

    // 以值的方式捕获 x
    auto lambda1 = [x] () { std::cout << "x = " << x << std::endl; };

    // 以引用的方式捕获 y
    auto lambda2 = [&y] () { std::cout << "y = " << y << std::endl; };

    // 修改外部变量 x 和 y
    x = 100;
    y = 200;

    // 调用 lambda 函数
    lambda1(); // 输出 x = 10
    lambda2(); // 输出 y = 200

    return 0;
}

```

常用的捕获情况如下：  
```
[]：默认不捕获任何变量；
[=]：默认以值捕获所有变量；
[&]：默认以引⽤捕获所有变量；
[x]：仅以值捕获x，其它变量不捕获；
[&x]：仅以引⽤捕获x，其它变量不捕获；
[=, &x]：默认以值捕获所有变量，但是x是例外，通过引⽤捕获；
[&, x]：默认以引⽤捕获所有变量，但是x是例外，通过值捕获；
[this]：通过引⽤捕获当前对象（其实是复制指针）；
[*this]：通过传值⽅式捕获当前对象；
```

### 错误的使用方式  
* 不调用lambda表达式
```
将 lambda 表达式作为条件判断的一部分，以确定 usDataLen 是否小于 lambda 表达式返回的值
if (usDataLen < [] ()->UINT16 { return STRUCT_OFFSET(ATS_MSG_HEARTBEAT_T, usCRC) - STRUCT_OFFSET(ATS_MSG_HEARTBEAT_T, ucDevStatus); })
{
/// TODO
}
这是错误的用法，因为 lambda 表达式没有被调用。在 C++ 中，不能直接在条件判断中使用 lambda 表达式，因为 lambda 表达式必须先被调用才能得到返回值。

正确做法：
auto compareLambdaResult = [] ()->UINT16 { return STRUCT_OFFSET(ATS_MSG_HEARTBEAT_T, usCRC) - STRUCT_OFFSET(ATS_MSG_HEARTBEAT_T, ucDevStatus); };

if (usDataLen < compareLambdaResult())
{
    /// TODO
}

```

* 指定返回值时省略参数列表
```
auto compareLambdaResult = ->UINT16 { return STRUCT_OFFSET(ATS_MSG_HEARTBEAT_T, usCRC) - STRUCT_OFFSET(ATS_MSG_HEARTBEAT_T, ucDevStatus); };

if (usDataLen < compareLambdaResult())
{
    /// TODO
}

错误，箭头 `->` 用于指定返回类型，但它必须位于参数列表之后,可以不指定返回值类型自动推导然后将`()`与`->`同时省略。

正确做法：
auto compareLambdaResult = ()->UINT16 { return STRUCT_OFFSET(ATS_MSG_HEARTBEAT_T, usCRC) - STRUCT_OFFSET(ATS_MSG_HEARTBEAT_T, ucDevStatus); };

if (usDataLen < compareLambdaResult())
{
    /// TODO
}

```

# constexpr  
修饰常量对象  
例如在C语言中声明常量通常是`#define test_const_value 1`  
使用constexpr可以是`constexpr int n=1`  
constexpr 还可以用来修饰函数、对象等  

# 基于范围的for循环  
按照容器范围遍历  
例如 
```
int arr[5] = {0};
std:vector<int> var;

for (int x : arr) /// x是arr的副本

for (int &x : arr) /// x是arr的引用，修改x会修改arr元素的数据

for (const int &x : arr ) /// x是arr的常量引用，不允许修改但是减少了一次拷贝

for (auto x : var) /// x是var的元素的自动类型推导的引用

for (const auto x : var) /// x是var的元素的自动类型推导的常量引用

```
