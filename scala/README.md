# Scala

--------------------------
#### scala学习资源
[相关书籍](http://192.168.32.106:8000/Book/)


#### 工具安装
1. idea（安装scala插件）
    > Settings -> Plugins -> 搜索Scala
1. sbt
    ##### Ubuntu
    ```
    echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
    sudo apt-get update
    sudo apt-get install sbt
    ```
    ##### Windows
    [下载链接](http://www.scala-sbt.org/download.html)
    
    ##### 教程
   [link1]()
   
   [link2]()
   
    ##### 基本配置
    由于sbt下载依赖的速度实在是太慢了
   
    使用repox.gtan.com源加速sbt下载：
   
    ###### Ubuntu
        ```
        mkdir ~/.sbt/
        echo '[repositories]
             local
             repox-maven: http://192.168.32.106:8078/
             repox-ivy: http://192.168.32.106:8078/, [organization]/[module]/(scala_[scalaVersion]/)(sbt_[sbtVersion]/)[revision]/[type]s/[artifact](-[classifier]).[ext]
        ' > ~/.sbt/repositories 
        ```
       
    ###### Windows
      > sbt安装目录 -> conf -> 
   
   
   
   ```
   //TODO
   ```