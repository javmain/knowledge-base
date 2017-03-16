# Akka Http

## 数据格式

REST服务应复用 **Http status** ，文本数据格式推荐使用 **JSON** 。只有当Http响应码为：200、201或204时认为请求成功。当请求失败或
错误时除了设置相应的Http响应码，返回内容也应为JSON格式，其中：`errCode`和`errMsg`必传：

```json
{
  "errCode": 500,
  "errMsg": "错误描述",
  "data": JSON, // 附加数据，具体类型由API决定
}
```

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

