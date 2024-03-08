## 子模块.gitsubmodules使用
在实际开发中我们有如下代码库：LTE集群代码库（包括调度台，调度服务器，录音录像服务器&终端，网管服务器&操作终端）、车载台嵌入式软件代码库、固定台嵌入式软件代码库。  
实操中发现如下问题：  
1、版本发布时不集中  
2、issue提交不集中，现场问题BUG可能涉及多个网元但是只在一个库提交  

```

这通常发生在你试图添加一个非空的目录作为子模块，并且该目录尚未被初始化为 Git 仓库。为了解决这个问题，你可以手动进行以下步骤：

1. 进入目标目录并初始化为 Git 仓库：
    ```bash
    cd TX/build_dir/linux-ar71xx_generic/linux-3.3.8
    git init
    ```

2. 将该目录连接到子模块的远程仓库：
    ```bash
    git remote add origin git@gitlab.gbcom.com.cn:SDK/QSDK_10_2_KERNEL.git
    ```

3. 拉取远程仓库的内容：
    ```bash
    git pull origin master
    ```

这样你就手动将该目录初始化为一个 Git 仓库，并连接到你想要作为子模块的远程仓库。最后，它会拉取远程仓库中的内容到这个目录中。完成后，你可以回到项目的根目录并尝试再次运行 `git submodule add` 命令。

```bash
git submodule add git@gitlab.gbcom.com.cn:SDK/QSDK_10_2_KERNEL.git ./TX/build_dir/linux-ar71xx_generic/linux-3.3.8/

当你再次运行 `git submodule add` 时，Git 应该能够正确地初始化子模块，并且可以在父项目中正确地追踪它。

```





## gitlab 不能直接上传超过10M文件
`curl.exe --request POST --header "Private-Token: z31sGkhX_EwRSxAZtgNz" --form "file=@D:\\常用软件\\tftp\\unzip(1)\unzip.exe" "http://gitlab.gbcom.com.cn/api/v4/projects/847/uploads"`  
Private-Token 是你的私钥令牌  
file=@D:\\常用软件\\tftp\\unzip(1)\unzip.exe 指定想要上传的文件  
http://gitlab.gbcom.com.cn/api/v4/projects/847/uploads 项目库 

## 撤销上一个commit  
1. 保留本地修改
如果你希望保留本地修改，但撤销最新的本地提交，可以使用 --soft 选项：`git reset --soft HEAD^`
2. 删除本地修改
如果你希望删除本地修改并撤销最新的本地提交，可以使用 --hard 选项：`git reset --hard HEAD^`

## 如何删除重复的origin  
要删除重复的`origin`远程仓库配置，可以使用`git remote remove`命令。以下是删除重复的`origin`的步骤：

1. 首先，使用`git remote -v`命令检查当前的远程仓库配置，确认有重复的`origin`。

   ```
   git remote -v
   ```

2. 如果确实存在重复的`origin`，可以使用`git remote remove`命令删除其中一个。

   ```
   git remote remove origin
   ```

   请确保仅删除重复的`origin`，而不是删除正确配置的远程仓库。确认删除前，最好再次验证远程仓库的URL和名称，以免误删除。

3. 删除后，你可以重新添加正确的远程仓库配置，使用`git remote add`命令。

   ```
   git remote add origin <远程仓库URL>
   ```

   将`<远程仓库URL>`替换为正确的远程仓库URL。

这样就可以删除重复的`origin`远程仓库配置，并重新添加正确的配置。记得在操作前确认好远程仓库的URL和名称，避免删除错误的配置。

## git clone 选择指定的分支
是的，使用`git clone`命令可以选择克隆指定的分支。默认情况下，`git clone`会将远程仓库的`HEAD`指向的分支克隆到本地。

如果你希望克隆特定的分支而不是`HEAD`指向的分支，可以使用`-b`参数来指定要克隆的分支。以下是克隆指定分支的示例：

```
git clone -b <分支名称> <远程仓库URL>
```

将`<分支名称>`替换为你想要克隆的分支的名称，将`<远程仓库URL>`替换为远程仓库的URL。

例如，要克隆名为`development`的分支，可以使用以下命令：

```
git clone -b development <远程仓库URL>
```

这将克隆`development`分支到本地仓库。请确保分支名称和远程仓库的URL是正确的。

## 添加sshKey的步骤
在 Windows 10 上添加 SSH 密钥的步骤如下：

1. 打开 Git Bash：在开始菜单中搜索 "Git Bash"，然后点击打开。

2. 在 Git Bash 终端中，输入以下命令来生成 SSH 密钥：
   ```
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```
   将 `"your_email@example.com"` 替换为你的电子邮件地址。

3. 提示你输入密钥的文件名和保存路径，按 Enter 键接受默认值（一般会在用户主目录下的 `.ssh` 文件夹中保存）。

4. 提示你输入要设置的密码短语（passphrase）。密码短语用于保护你的 SSH 密钥，可以为空，直接按 Enter 键跳过。

5. 生成密钥对后，你会看到输出类似于以下内容：
   ```
   Your identification has been saved in /c/Users/your_username/.ssh/id_rsa.
   Your public key has been saved in /c/Users/your_username/.ssh/id_rsa.pub.
   ```

6. 使用以下命令查看你的公钥：
   ```
   cat ~/.ssh/id_rsa.pub
   ```

7. 复制公钥内容（以 `ssh-rsa` 开头的一行）。

8. 登录到你的 Git 托管服务提供商（如 GitHub、GitLab、Bitbucket 等）的网站。

9. 打开你的账户设置或个人配置页面，找到 SSH 密钥设置。

10. 粘贴之前复制的公钥内容到相应的字段中，并保存。

现在，你已经成功添加了 SSH 密钥，可以使用 SSH 协议与远程仓库进行交互，而无需每次输入密码。

