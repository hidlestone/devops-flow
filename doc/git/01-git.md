## 01-git

### 一、git的历史
同生活中的许多伟大事件一样，Git 诞生于一个极富纷争大举创新的年代。Linux 内核开源项目有着为数众广的参与者。绝大多数的 Linux 内核维护工作都花在了提交补丁和保存归档的繁琐事务上（1991－2002年间）。到 2002 年，整个项目组开始启用分布式版本控制系统 BitKeeper 来管理和维护代码。    
到 2005 年的时候，开发 BitKeeper 的商业公司同 Linux 内核开源社区的合作关系结束，他们收回了免费使用 BitKeeper 的权力。这就迫使 Linux 开源社区（特别是 Linux的缔造者 Linus Torvalds ）不得不吸取教训，只有开发一套属于自己的版本控制系统才不至于重蹈覆辙。他们对新的系统订了若干目标：
- 速度
- 简单的设计
- 对非线性开发模式的强力支持（允许上千个并行开发的分支）
- 完全分布式
- 有能力高效管理类似 Linux 内核一样的超大规模项目（速度和数据量）


### 二、git与svn的对比
#### 2.1、svn
SVN是集中式版本控制系统，版本库是集中放在中央服务器的，而干活的时候，用的都是自己的电脑，所以首先要从中央服务器哪里得到最新的版本，然后干活，干完后，需要把自己做完的活推送到中央服务器。集中式版本控制系统是必须联网才能工作，如果在局域网还可以，带宽够大，速度够快，如果在互联网下，如果网速慢的话，就郁闷了。

![svn-01](./images/svn-01.png)

集中管理方式在一定程度上看到其他开发人员在干什么，而管理员也可以很轻松掌握每个人的开发权限。

但是相较于其优点而言，集中式版本控制工具缺点很明显：
- 服务器单点故障
- 容错性差

#### 2.2、Git
Git是分布式版本控制系统，那么它就没有中央服务器的，每个人的电脑就是一个完整的版本库，这样，工作的时候就不需要联网了，因为版本都是在自己的电脑上。既然每个人的电脑都有一个完整的版本库，那多个人如何协作呢？比如说自己在电脑上改了文件A，其他人也在电脑上改了文件A，这时，你们两之间只需把各自的修改推送给对方，就可以互相看到对方的修改了。

![git-01](./images/git-01.png)


### 三、git工作流程
一般工作流程如下：
- 1、从远程仓库中克隆 Git 资源作为本地仓库。
- 2、从本地仓库中checkout代码然后进行代码修改
- 3、在提交前先将代码提交到暂存区。
- 4、提交修改。提交到本地仓库。本地仓库中保存修改的各个历史版本。
- 5、在修改完成后，需要和团队成员共享代码时，可以将代码push到远程仓库。

![git-02](./images/git-02.png)


### 四、git的安装
#### 4.1、软件下载
下载地址：https://git-scm.com/download

#### 4.2、软件安装
##### 4.2.1、安装git for windows

##### 4.2.2、安装TortoiseGit
配置开发者姓名及邮箱，每次提交代码时都会把此信息包含到提交的信息中。
![git-03](./images/git-03.png)

安装完毕后在系统右键菜单中会出现git的菜单项。
![git-04](./images/git-04.png)

##### 4.2.3、安装中文语言包
![git-05](./images/git-05.png)


### 五、使用git管理文件版本
#### 5.1、创建版本库
什么是版本库呢？版本库又名仓库，英文名repository，可以简单理解成一个目录，这个目录里面的所有文件都可以被Git管理起来，每个文件的修改、删除，Git都能跟踪，以便任何时刻都可以追踪历史，或者在将来某个时刻可以“还原”。由于git是分布式版本管理工具，所以git在不需要联网的情况下也具有完整的版本管理能力。

使用git bash也可以使用tortoiseGit。首先，选择一个合适的地方，创建一个空目录


##### 5.1.1、使用GitBash
切换目录到仓库所在的目录。
创建仓库执行命令：
```
$ git init
```

##### 5.1.2、使用TortoiseGit
![git-06](./images/git-06.png)

![git-07](./images/git-07.png)

版本库创建成功，会在此目录下创建一个.git的隐藏目录，如下所示：
![git-08](./images/git-08.png)


概念
- 版本库：“.git”目录就是版本库，将来文件都需要保存到版本库中。
- 工作目录：包含“.git”目录的目录，也就是.git目录的上一级目录就是工作目录。只有工作目录中的文件才能保存到版本库中。

#### 5.2、添加文件
##### 5.2.1、添加文件过程
在D:\temp\git\repository目录下创建一个mytest.txt文件

![git-09](./images/git-09.png)

![git-10](./images/git-10.png)

![git-11](./images/git-11.png)

文本文件变为带“+”号的图标：
![git-12](./images/git-12.png)

提交文件：在mytest.txt上再次点击右键选择“提交”，此时将文件保存至版本库中。
![git-13](./images/git-13.png)

![git-14](./images/git-14.png)

![git-15](./images/git-15.png)
如果是需要提交到不同的分支下。先转换到所需要提交的那个分支下。


##### 5.2.2、工作区和暂存区
Git和其他版本控制系统如SVN的一个不同之处就是有暂存区的概念。

什么是工作区（Working Directory）？             
工作区就是电脑里的目录，比如reporstory文件夹就是一个工作区。      
其实repository目录是工作区，在这个目录中的“.git”隐藏文件夹才是版本库。             
Git的版本库里存了很多东西，其中最重要的就是称为stage（或者叫index）的暂存区，还有Git为我们自动创建的第一个分支master，以及指向master的一个指针叫HEAD。

![git-16](./images/git-16.png)

把文件往Git版本库里添加的时候，是分两步执行的：
- 第一步：是用git add把文件添加进去，实际上就是把文件修改添加到暂存区；
- 第二步：是用git commit提交更改，实际上就是把暂存区的所有内容提交到当前分支。

创建Git版本库时，Git自动为我们创建了唯一一个master分支，所以，现在，git commit就是往master分支上提交更改。    
可以简单理解为，需要提交的文件修改通通放到暂存区，然后，一次性提交暂存区的所有修改。


#### 5.3、修改文件
##### 5.3.1、提交修改
被版本库管理的文件不可避免的要发生修改，此时只需要直接对文件修改即可。修改完毕后需要将文件的修改提交到版本库。在mytest.txt文件上点击右键，然后选择“提交”。

![git-17](./images/git-17.png)

![git-18](./images/git-18.png)


##### 5.3.2、查看修改历史
在开发过程中可能会经常查看代码的修改历史，或者叫做修改日志。来查看某个版本是谁修改的，什么时间修改的，修改了哪些内容。         
可以在文件上点击右键选择“显示日志”来查看文件的修改历史。
![git-19](./images/git-19.png)

![git-20](./images/git-20.png)

##### 5.3.3、差异比较
![git-21](./images/git-21.png)

##### 5.3.4、还原修改
当文件修改后不想把修改的内容提交，还想还原到未修改之前的状态。此时可以使用“还原”功能。
![git-22](./images/git-22.png)

![git-23](./images/git-23.png)

![git-24](./images/git-24.png)
注意：此操作会撤销所有未提交的修改，所以当做还原操作是需要慎重慎重！！！

#### 5.4、删除文件
需要删除无用的文件时可以使用git提供的删除功能直接将文件从版本库中删除。
![git-25](./images/git-25.png)


#### 5.5、案例：将java工程提交到版本库
- 第一步：将参考资料中的java工程project-test复制到工作目录中
- 第二步：将工程添加到暂存区。-->点击确定完成暂存区添加。

忽略文件或文件夹     
在此工程中，并不是所有文件都需要保存到版本库中的例如“bin”目录及目录下的文件就可以忽略。好在Git考虑到了大家的感受，这个问题解决起来也很简单，在Git工作区的根目录下创建一个特殊的.gitignore文件，然后把要忽略的文件名填进去，Git就会自动忽略这些文件。
如果使用TortoiseGit的话可以使用菜单项直接进行忽略。

![git-26](./images/git-26.png)

![git-27](./images/git-27.png)

选择保留本地文件。完成后在此文件夹内会多出一个.gitignore文件，这个文件就是文件忽略文件，当然也可以手工编辑。其中的内容就是把bin目录忽略掉。

![git-28](./images/git-28.png)

提交代码      
将代码添加到master分支上，其中.gitignore文件也需要添加到暂存区，然后提交到版本库。


#### 5.6、忽略文件语法

```
空行或是以 # 开头的行即注释行将被忽略。
可以在前面添加正斜杠 / 来避免递归,下面的例子中可以很明白的看出来与下一条的区别。
可以在后面添加正斜杠 / 来忽略文件夹，例如 build/ 即忽略build文件夹。
可以使用 ! 来否定忽略，即比如在前面用了 *.apk ，然后使用 !a.apk ，则这个a.apk不会被忽略。
* 用来匹配零个或多个字符，如 *.[oa] 忽略所有以".o"或".a"结尾， *~ 忽略所有以 ~ 结尾的文件（这种文件通常被许多编辑器标记为临时文件）； [] 用来匹配括号内的任一字符，如 [abc] ，也可以在括号内加连接符，如 [0-9] 匹配0至9的数； ? 用来匹配单个字符。 
看了这么多，还是应该来个栗子：
# 忽略 .a 文件
*.a
# 但否定忽略 lib.a, 尽管已经在前面忽略了 .a 文件
!lib.a

# 仅在当前目录下忽略 TODO 文件， 但不包括子目录下的 subdir/TODO
/TODO
# 忽略 build/ 文件夹下的所有文件
build/

# 忽略 doc/notes.txt, 不包括 doc/server/arch.txt
doc/*.txt
# 忽略所有的 .pdf 文件 在 doc/ directory 下的
doc/**/*.pdf
```

### 六、远程仓库
#### 6.1、添加远程仓库
现在已经在本地创建了一个Git仓库，又想让其他人来协作开发，此时就可以把本地仓库同步到远程仓库，同时还增加了本地仓库的一个备份。

常用的远程仓库就是github：https://github.com/。

##### 6.1.1、在github上创建仓库
Github支持两种同步方式“https”和“ssh”。如果使用https很简单基本不需要配置就可以使用，但是每次提交代码和下载代码时都需要输入用户名和密码。如果使用ssh方式就需要客户端先生成一个密钥对，即一个公钥一个私钥。然后还需要把公钥放到githib的服务器上。这两种方式在实际开发中都有应用，

##### 6.1.2、ssh协议
6.1.2.1、什么是ssh

> SSH 为 Secure Shell（安全外壳协议）的缩写，由 IETF 的网络小组（Network Working Group）所制定。SSH 是目前较可靠，专为远程登录会话和其他网络服务提供安全性的协议。利用 SSH 协议可以有效防止远程管理过程中的信息泄露问题。

6.1.2.2、基于密钥的安全验证

> 使用ssh协议通信时，推荐使用基于密钥的验证方式。你必须为自己创建一对密匙，并把公用密匙放在需要访问的服务器上。如果你要连接到SSH服务器上，客户端软件就会向服务器发出请求，请求用你的密匙进行安全验证。服务器收到请求之后，先在该服务器上你的主目录下寻找你的公用密匙，然后把它和你发送过来的公用密匙进行比较。如果两个密匙一致，服务器就用公用密匙加密“质询”（challenge）并把它发送给客户端软件。客户端软件收到“质询”之后就可以用你的私人密匙解密再把它发送给服务器。

6.1.2.3、ssh密钥生成

在windows下我们可以使用 Git Bash.exe来生成密钥，可以通过开始菜单或者右键菜单打开Git Bash。

![git-29](./images/git-29.png)

![git-30](./images/git-30.png)

git bash 执行命令,生命公钥和私钥
```
ssh-keygen -t rsa
或者
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
(这里的your_email@example.com要改成你自己github上绑定的邮箱)

![git-31](./images/git-31.png)

如上页面说明生成成功，复制秘钥
```
$ clip < ~/.ssh/id_rsa.pub
```
执行命令完成后,在window本地用户.ssh目录C:\Users\用户名\.ssh下面生成如下名称的公钥和私钥:

![git-32](./images/git-32.png)

6.1.2.4、ssh密钥配置   
密钥生成后需要在github上配置密钥本地才可以顺利访问。

![git-33](./images/git-33.png)

![git-34](./images/git-34.png)
在key部分将id_rsa.pub文件内容添加进去，然后点击“Add SSH key”按钮完成配置。

检查是否和Github绑定成功
```
ssh -T git@github.com
```
如果出现了：You've successfully authenticated, but GitHub does not provide shell access 。那就说明，已经成功连上了GitHub。

还需要简单的设置一些东西。
```
$ git config --global user.name "payn"  
$ git config --global user.email "809566095@qq.com" 
```
输入上边的代码，name最好和GitHub上边的一样，这里的your_email@youremail.com要写成你自己github上绑定的邮箱

下面就要将你刚才创建的库克隆下来到本地电脑中，方便以后进行上传代码。
```
git clone git@github.com:hidlestone/inkblog.git
Cloning into 'inkblog'...
warning: You appear to have cloned an empty repository.
```

##### 6.1.3、同步到远程仓库
同步到远程仓库可以使用git bash也可以使用tortoiseGit

6.1.3.1、使用git bash         
在仓库所在的目录（D:\temp\git\repository）点击右键选择“Git Bash Here”，启动git bash (bash (n. 猛击))程序。

然后在git bash中执行如下语句：
```
git remote add origin git@github.com:hidlestone/mytest.git
git push -u origin master
```

6.1.3.2、使用TortoiseGit同步

1、由于TortoiseGit使用的ssh工具是“PuTTY”git Bash使用的ssh工具是“openSSH”，如果想让TortoiseGit也使用刚才生成的密钥可以做如下配置：

![git-35](./images/git-35.png)

![git-36](./images/git-36.png)

![git-37](./images/git-37.png)

- Url：远程仓库的地址
- 推送URL：也是相同的
- Putty密钥：选择刚才生成的密钥中的私钥

2、同步。在本地仓库的文件夹中单击右键，选择“Git同步”。
![git-38](./images/git-38.png)


#### 6.2、从远程仓库克隆
克隆远程仓库也就是从远程把仓库复制一份到本地，克隆后会创建一个新的本地仓库。选择一个任意部署仓库的目录，然后克隆远程仓库。

##### 6.2.1、使用git bash
```
git clone git@github.com:hidlestone/repo1.git 
```

##### 6.2.2、使用TortoiseGit
在任意目录点击右键：

![git-39](./images/git-39.png)

![git-40](./images/git-40.png)

![git-41](./images/git-41.png)


#### 6.3、从远程仓库区代码
Git中从远程的分支获取最新的版本到本地有这样2个命令：
- 1. git fetch：相当于是从远程获取最新版本到本地，不会自动merge（合并代码）
- 2. git pull：相当于是从远程获取最新版本并merge到本地

上述命令其实相当于git fetch 和 git merge   
在实际使用中，git fetch更安全一些   
因为在merge前，我们可以查看更新情况，然后再决定是否合并  
如果使用TortoiseGit的话可以从右键菜单中点击“拉取”（pull）或者“获取”（fetch）  

![git-42](./images/git-42.png)

#### 6.4、搭建私有Git服务器
##### 6..4.1、服务器搭建
远程仓库实际上和本地仓库没啥不同，纯粹为了7x24小时开机并交换大家的修改。GitHub就是一个免费托管开源代码的远程仓库。但是对于某些视源代码如生命的商业公司来说，既不想公开源代码，又舍不得给GitHub交保护费，那就只能自己搭建一台Git服务器作为私有仓库使用。

步骤：
- 1、安装git服务环境准备
```
yum -y install curl curl-devel zlib-devel openssl-devel perl cpio expat-devel gettext-devel gcc cc
在linux联网的情况下：yum install autoconf
```
- 2、下载git-2.5.0.tar.gz
    - 1）解压缩
    - 2）cd git-2.5.0
    - 3）autoconf  -->需要安装autoconf
    - 4）./configure
    - 5）make
    - 6）make install
    - 3、添加用户
```
adduser -r -c 'git version control' -d /home/git -m git    
```
此命令执行后会创建/home/git目录作为git用户的主目录。
- 5、设置密码
```
passwd git
```
　　输入两次密码
- 6、切换到git用户
```
su git
```
- 7、创建git仓库
```
git --bare init /home/git/first
```
注意：如果不使用“--bare”参数，初始化仓库后，提交master分支时报错。这是由于git默认拒绝了push操作，需要.git/config添加如下代码：
```
　　[receive]
　　　　denyCurrentBranch = ignore
推荐使用：git --bare init初始化仓库。
```

##### 6.4.2、连接服务器
私有git服务器搭建完成后就可以像连接github一样连接使用了，但是我们的git服务器并没有配置密钥登录，所以每次连接时需要输入密码。
使用命令连接：
```
　　$ git remote add origin ssh://git@192.168.121.132/home/git/repo1
```
这种形式和刚才使用的形式好像不一样，前面有ssh://前缀，好吧你也可以这样写：
```
　　$ git remote add origin git@192.168.25.156:/home/git/repo1
```

使用TortoiseGit同步的话参考上面的使用方法。
![git-43](./images/git-43.png)

