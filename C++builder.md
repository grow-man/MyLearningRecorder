# DevExpress 自定义皮肤工具`dxSkinEditor` build失败  
## 现象：编译自定义的skin工程时报错  
错误信息：  
```
Resource building failed!
Resource compiler not found!
```
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/3ab2f96c-7cd9-4fd2-b528-81c4c86791a6)  

## 尝试解决  
1.确定环境变量包含了`bcc32.exe`以及`brcc32.exe` 路径  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/e53be0e4-73ee-4ae8-9e2b-edb8bb039a9c)  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/ee270bb9-9c91-4caf-8699-89471d64a38a)  

2.将`bcc32.exe`以及`brcc32.exe`拷贝到`dxSkinEditor`安装路径，问题仍然存在  

3.更换电脑：更换多台电脑(4台)，只有其中一台可以正常build，对比环境变量及安装路径没有差异  

## `dxSkinEditor`版本  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/18706761-5b1e-4280-a8a0-98c9545b9a19)  

## 在官网查到有类似问题，官方并未给出明确的解决方案  
[官网问答](https://supportcenter.devexpress.com/ticket/details/b141932/the-skin-editor-cannot-find-the-embarcadero-delphi-2010-resource-compiler)   

![56f376b54f304ee144d37d7c80d90c5](https://github.com/grow-man/MyLearningRecorder/assets/52662997/8978eb57-7065-4d05-8764-4ac28a8f29d2)  

# 可视化文件选择控件`TFileOpenDialog`  
1.TFileOpenDialog 空间是 C++ Builder 提供的一个用于在应用程序中显示文件打开对话框的组件。通过这个组件，用户可以以可视化的方式在系统中选择任意文件。  
成员函数`Execute `提供一个可视化的文件打开对话框供用户选择文件。  
2.`option`选项可以设置文件是否是只读、是否允许选择多个文件等。   
3.示例如下：  
```
TFileOpenDialog *dlgOpenFile = new TFileOpenDialog(NULL);
try
{
    dlgOpenFile->Options << ofReadOnly << ofAllowMultiSelect; // 设置只读选项和允许多选

    if (dlgOpenFile->Execute())
    {
        // 用户点击了 "打开" 按钮
        TStrings *SelectedFiles = dlgOpenFile->Files;
        for (int i = 0; i < SelectedFiles->Count; ++i)
        {
            ShowMessage("选中的文件是：" + SelectedFiles->Strings[i]);
        }
    }
    else
    {
        // 用户点击了 "取消" 按钮或关闭了对话框
        ShowMessage("用户取消了操作");
    }
}
__finally
{
    delete dlgOpenFile;
}

```

# 记录控件`TcxTreeListNode` 的`DataBinging`属性导致软件崩溃  

## 现象

将一个超过2147483647 的无符号整数赋值给`TcxTreeListNode` 控件时软件崩溃，报错信息为:`Overflow while converting variant of type (UnicodeString) into type (Integer)`   

![05d452d8b75b2b8389c5cb34962a49a](https://github.com/grow-man/MyLearningRecorder/assets/52662997/19288088-1951-485e-ab3a-2e13a1d0986a)  

## 原因  

控件`TcxTreeListNode`缺省属性是`integer `它通常表示32位的有符号整数，所以将一个一个超过2147483647 的无符号整数赋值`TcxTreeListNode`会导致软件崩溃。  
可以将它设置为`largelnt `以表示更大的范围(64位有符号数)来规避此问题。  

### 修改前  

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/e36c3ca8-13d1-4720-b2b5-0f8ee8eb0ecb)  

### 修改后  

![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/040d4a9e-d3a3-4b0a-a510-c0a15a476587)  


# 锚点导致的按钮错位问题  

使用如下代码来控制按钮的排列间隔：
```
void __fastcall TDialogIPH::InitWorkPanel()
{

    TcxButton   *btns[] = { btnAnswer,
                            btnHangup,
                            btnIPHPTT,
                            btnExit
                          };

    gbIPHWorkSpace->Width = 160;

    UINT32 ulInterval = 20;

    /// 第一个按钮初始化
    btns[0]->TabOrder = 0;
    btns[0]->Width = UICfg::GetMidToolbarButtonWidth();
    btns[0]->Height = UICfg::GetMidToolbarButtonHeight();
    btns[0]->Left = (btns[0]->Parent->Width - btns[0]->Width)/2;
    btns[0]->Top = ulInterval;

    for (UINT32 i=1; i<ARRAY_SIZE(btns); i++)
    {
        btns[i]->TabOrder = i;
        btns[i]->Width = UICfg::GetMidToolbarButtonWidth();
        btns[i]->Height = UICfg::GetMidToolbarButtonHeight();
        btns[i]->Left = (btns[i]->Parent->Width - btns[i]->Width)/2;

        btns[i]->Top = btns[i-1]->Top + 
                    UICfg::GetMidToolbarButtonHeight() + ulInterval;
    }
}
```
预期`btnIPHPTT`,的Top的值是204，构造函数调用`InitWorkPanel`该函数运行后能得到期望值，但是实际弹出弹窗时Top被修改为284，分析原因是控件属性`Anchors`被设置为
akRight + akBottom,即设置锚点为右边缘和下边缘。所以按钮每次弹窗都会以此锚点来修改按自身的Top。

经验：当出现按钮位置与实际预期不一致时需要检查锚点`Anchors`是否符合预期。  

# 控件`TCTrayIcon`  

![image](https://github.com/user-attachments/assets/0859da7c-8e57-468d-8d5c-a786b4243f5b)  

该控件有一个方法`->Restore()`会将最小化的父控件恢复到原始位置，当发现软件最小化后自动弹窗占据画面而主界面未出现时可以在弹窗前先调用此方法  

以下是该控件的介绍：
```
TCTrayIcon 控件用于在 Windows 系统托盘（也称为通知区域）中显示图标，并处理用户在系统托盘中的操作，如单击、双击和右键菜单。以下是如何使用 TCTrayIcon 控件的一些基本步骤和示例代码：

添加 TCTrayIcon 控件
在窗体设计器中添加控件：

从工具箱中选择 TCTrayIcon 控件，并将其拖放到窗体上。
设置属性：

Icon: 设置要显示在系统托盘中的图标。
Hint: 设置鼠标悬停在图标上时显示的提示文本。
Visible: 设置图标是否可见。
PopupMenu: 设置右键单击图标时显示的弹出菜单。
```






