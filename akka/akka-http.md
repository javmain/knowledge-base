# Akka Http

## 推荐 Akka Http 微服务目录：

- boot：启动程序文件和全局服务object
- config：系统配置参数
- inject：Guice依赖相关，如：Module
- route：路由定义（Http访问）
- service：业务定义
- constant：应用级常量
- util: 工具函数

**boot**

一般需要定义两个 `object`，分别为包含 `main` 方法的程序启动代码和保存 `Guice injector` 的 `Server`。
推荐使用：`[应用程序名]Boot` 和 `[应用程序名]Server` 方式命名，如：

```scala
object ApiAgentBoot {
  def main(args: Array[String]) {
    ....
  }
}

object ApiAgentServer {
  val injector: Injector = Guice.createInjector(new HLBuiltinModule, new IgApiAgentModule)

  def getInstance[T](typ: Class[T]): T = injector.getInstance(typ)  
}
```

**config**

通过 `typesafe config`、**服务发现**或**环境变量**等工具获取的应用及系统级配置代码。

**route**

Akka Http Route DSL代码放置在此，推荐使用一个 `Routes` 来汇总所有 **Route** ，如：

```scala
@Singleton
class Routes @Inject()(newsRoutes: NewsRoute,
                       systemRoutes: SystemRoute,
                       ....,
                       actorSystem: ActorSystem) extends AkkaHttpRoutes {
  def route: Route =
    ....
}
```

