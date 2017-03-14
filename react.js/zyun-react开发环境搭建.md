从零开始搭建React开发环境

最近刚好又装了一个笔记本的开发环境，主要是前端开发环境这块！

要说有什么高深的知识也谈不上，不过有些小东西倒还是值得拿出来分享给大家的！当然一般会有人协助安装开发环境，不过还是建议自己能搞定的自己动手！

### 第一步：一切的起源得从node开始

node百度云下载链接（版本号：node-v6.9.1-win-x64）：链接：http://pan.baidu.com/s/1skXDxfR 密码：kqdx

解压后放到一个磁盘目录，然后需要配置环境变量，这样才能生效。

### 第二步：当然有了这个东东后，我们需要装一个叫做cnpm的东西：

淘宝镜像说明地址：[http://npm.taobao.org/](http://npm.taobao.org/)

安装操作命令：<span style="font-family: 'Courier New'; font-size: 12px; line-height: 1.5;">npm install</span> <span class="pun" style="font-family: 'Courier New'; font-size: 12px; line-height: 1.5;">-<span class="pln">g cnpm <span class="pun">--<span class="pln">registry<span class="pun">=<span class="pln">https<span class="pun">://<span class="pln">registry<span class="pun">.<span class="pln">npm<span class="pun">.<span class="pln">taobao<span class="pun">.<span class="pln">org</span></span></span></span></span></span></span></span></span></span></span></span></span></span>

### 第三步：安装git（这一步和第六步的2小点相同的）

详细安装操作请移步：[http://www.cnblogs.com/zxyun/p/4744744.html](http://www.cnblogs.com/zxyun/p/4744744.html)

### 第四步：克隆远程项目到本地

命令：git clone '你的项目地址或者是github上的地址'

安装项目依赖：在项目根路径执行命令：cnpm  install 

### 第五步：安装前端开发工具——webStorm

这个工具非常强大，其他的优点不做累述

### 第六步:配置webStorm的编译插件和一些其他的代码风格，常用快捷键设置之类等等

详细说明请移步：

1.配置编译插件：[http://www.cnblogs.com/zxyun/p/6140711.html](http://www.cnblogs.com/zxyun/p/6140711.html)

2.配置git：[http://www.cnblogs.com/zxyun/p/4744744.html](http://www.cnblogs.com/zxyun/p/4744744.html)

3.一些自己总结的小技巧：[http://www.cnblogs.com/zxyun/category/725668.html](http://www.cnblogs.com/zxyun/category/725668.html)

风格jar包赠送百度云地址：

### 第七步：配置nginx和host（这一步暂时省略）