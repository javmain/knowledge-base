# Java 编码规约

本规约参考了大部分 [《阿里巴巴Java开发手册v1。2。0》](阿里巴巴Java开发手册v1。2。0。pdf) ，在此表达最崇高的敬意。

## 编程规约

### 命名风格

1. **[强制]** 代码中的命名均不能以*下划线或美元符号*开始，也不能以*下划线或美元符号*结束。

    反例： `_name / __name / $Object / name_ / name$ / Object$`

2. **[强制]** 代码中的命名严禁使用拼音与英文混合的方式，更不允许直接使用中文的方式。正确的英文拼写和语法可以让阅读者易于理解，避免歧义。注意，即使纯拼音命名方式也要避免采用。

    **正例：** `alibaba / taobao / youku / hangzhou 等国际通用的名称，可视同英文。`
    反例：`DaZhePromotion [ 打折 ] / getPingfenByName() [ 评分 ] / int 某变量 = 3`

3. **[强制]** 类名使用 UpperCamelCase 风格，必须遵从驼峰形式，但以下情形例外（领域模型的相关命名）DO / BO / DTO / VO 等。

    **正例：** `MarcoPolo / UserDO / XmlService / TcpUdpDeal / TaPromotion`
    反例： `macroPolo / UserDo / XMLService / TCPUDPDeal / TAPromotion`

4. **[强制]** 方法名、参数名、成员变量、局部变量都统一使用 lowerCamelCase 风格，必须遵从驼峰形式。

    正例： `localValue / getHttpMessage() / inputUserId`

5. **[强制]** 常量命名全部大写，单词间用下划线隔开，力求语义表达完整清楚，不要嫌名字长。

    **正例：** `MAX_STOCK_COUNT`
    反例： `MAX_COUNT`

6. **[强制]** 抽象类命名使用 Abstract 或 Base 开头；异常类命名使用 Exception 结尾，测试类命名以它要测试的类的名称开始，以 Test 结尾。

7. **[强制]** 中括号是数组类型的一部分，数组定义如下： String[] args；

    反例：使用 `String args[]` 的方式来定义。

8. **[强制]** POJO 类中布尔类型的变量，都不要加 is ，否则部分框架解析会引起序列化错误。

    反例：定义为基本数据类型 Boolean isSuccess； 的属性，它的方法也是 isSuccess() ，RPC框架在反向解析的时候，以为”对应的属性名称是 success，导致属性获取不到，进而抛出异常。

9. **[强制]** 包名统一使用小写，点分隔符之间有且仅有一个自然语义的英语单词。包名统一使用单数形式，但是类名如果有复数含义，类名可以使用复数形式。

    **正例：** 应用工具类包名为 `com.hualongdata.util`、类名为 MessageUtils（此规则参考spring 的框架结构）

10. **[强制]** 杜绝完全不规范的缩写，避免望文不知义。

    反例：AbstractClass “缩写” 命名成 AbsCls；condition “缩写” 命名成 condi，此类随意缩写严重降低了代码的可读性。

11. **[推荐]** 如果使用到了设计模式，建议在类名中体现出具体模式。
    *说明：将设计模式体现在名字中，有利于阅读者快速理解架构设计思想。*
    **正例**： 
```java
public class OrderFactory；
public class LoginProxy；
public class ResourceObserver；
```

12. **[推荐]** 接口类中的方法和属性不要加任何修饰符号 (public 也不要加 ) ，保持代码的简洁性，并加上有效的Javadoc 注释。尽量不要在接口里定义变量，如果一定要定义变量，肯定是与接口方法相关，并且是整个应用的基础常量。

    **正例：** 接口方法签名： `void f()`；接口基础常量表示： `String COMPANY = "alibaba"`；
    反例：接口方法定义： `public abstract void f()`；
    说明： JDK 8 中接口允许有默认实现，那么这个 default 方法，是对所有实现类都有价值的默认实现。

13. **[强制]** 接口和实现类的命名有两套规则：

    1) **强制** 对于 Service 和 DAO 类，基于 SOA 的理念，暴露出来的服务一定是接口，内部的实现类用 Impl 的后缀与接口区别。
    正例： CacheServiceImpl 实现 CacheService 接口。
    2) **推荐** 如果是形容能力的接口名称，取对应的形容词做接口名（通常是-able的形式）。
    正例： AbstractTranslator 实现 Translatable 接口。

14. **[参考]** 枚举类名建议带上 Enum 后缀，枚举成员名称需要全大写，单词间用下划线隔开。

    说明：枚举其实就是特殊的常量类，且构造方法被默认强制是私有。
    正例：枚举名字： DealStatusEnum， 成员名称： `SUCCESS` / `UNKOWN_REASON` 。

15. **[参考]** 各层命名规约：

    A) Service / DAO 层方法命名规约
      1) 获取单个对象的方法用 get 做前缀。
      2) 获取多个对象的方法用 list 做前缀。
      3) 获取统计值的方法用 count 做前缀。
      4) 插入的方法用 `save` (推荐) 或 insert 做前缀。
      5) 删除的方法用 `remove` (推荐) 或 delete 做前缀。
      6) 修改的方法用 `update` 做前缀。
    B) 领域模型命名规约
      1) 数据对象： xxxDO， xxx即为数据表名。
      2) 数据传输对象： xxxDTO， xxx为业务领域相关的名称。
      3) 展示对象： xxxVO， xxx一般为网页名称。
      4) POJO 是 DO/DTO/BO/VO 的统称，禁止命名成xxxPOJO。

### 常量定义

1. **[强制]** 不允许任何魔法值（即未经定义的常量）直接出现在代码中。

    反例： 
```
String key = "Id#hl_" + tradeId； // "Id#hl_" 应定义成常量
cache.put(key ， value)；
```

2. **[强制]**  long 或者 Long 初始赋值时，必须使用大写的 ，不能是小写l，小写容易跟数字1混淆，造成误解。

    说明： `Long a = 2l`； 写的是数字的21，还是Long型的2？

3. **[推荐]** 不要使用一个常量类维护所有常量，应该按常量功能进行归类，分开维护。如：缓存相关的常量放在类： `CacheConsts`下；系统配置相关的常量放在类：`ConfigConsts`下。

    说明：大而全的常量类，非得使用查找功能才能定位到修改的常量，不利于理解和维护。

4. **[推荐]** 常量的复用层次有五层：跨应用共享常量、应用内共享常量、子工程内共享常量、包内共享常量、类内共享常量。

    1) 跨应用共享常量：放置在二方库中，通常是 client.jar 中的 constant 目录下。
    2) 应用内共享常量：放置在一方库的 modules 中的 constant 目录下。
      反例：易懂变量也要统一定义成应用内共享常量，两位攻城师在两个类中分别定义了表示“是”的变量：
      类 A 中： `public static final String YES = "yes"`；
      类 B 中： `public static final String YES = "y"`；
      `A.YES.equals(B.YES)`，预期是true，但实际返回为false，导致线上问题。
    3) 子工程内部共享常量：即在当前子工程的 constant 目录下。
    4) 包内共享常量：即在当前包下单独的 constant 目录下。
    5) 类内共享常量：直接在类内部 private static final 定义。

5. **[推荐]** 如果变量值仅在一个范围内变化，且带有名称之外的延伸属性，定义为枚举类。下面正例中的数字就是延伸信息，表示星期几。

    正例： 

```java
public Enum { 
    MONDAY(1)， 
    TUESDAY(2)， 
    WEDNESDAY(3)， 
    THURSDAY(4)， 
    FRIDAY(5)， 
    SATURDAY(6)，
    SUNDAY(7)；
}
```

## 数据库访问

### ORG映射

1. **[强制]** 在表查询中，一律不要使用 * 作为查询的字段列表，需要哪些字段必须明确写明。

    说明：
    1) 增加查询分析器解析成本。
    2) 增减字段容易与 resultMap 配置不一致。

2. **[强制]**  POJO 类的 **布尔** 属性不能加 is，要求在 resultMap 中进行字段与属性之间的映射。

    说明：参见定义 POJO 类以及数据库字段定义规定，在 <resultMap>中 增加映射，是必须的。在 MyBatis Generator 生成的代码中，需要进行对应的修改。

3. **[强制]** **MyBatis** 不要用 resultClass 当返回参数，即使所有类属性名与数据库字段一一对应，也需要定义；反过来，每一个表也必然有一个与之对应。

    说明：配置映射关系，使字段与 DO 类解耦，方便维护。

4. **[强制]** **MyBatis** 的`sql.xml`配置参数使用： `#{}`， `#param#` 不要使用`${}` 此种方式容易出现 SQL 注入。

5. **[强制]** **MyBatis** 不允许直接拿 HashMap 与 Hashtable 作为查询结果集的输出。

    说明：resultClass="Hashtable"，会置入字段名和属性值，但是值的类型不可控。

7. **[强制]** 更新数据表记录时，必须同时更新记录对应的 `updated_at` 字段值为当前时间。

8. **[推荐]** **MyBatis** 不要写一个大而全的数据更新接口，传入为 POJO 类，不管是不是自己的目标更新字段，都进行 update table set c1=value1，c2=value2，c3=value3； 这是不对的。执行SQL时，不要更新无改动的字段，一是易出错；二是效率低；三是增加 binlog 存储。

9. **[参考]** @Transactional 事务不要滥用。事务会影响数据库的QPS ，另外使用事务的地方需要考虑各方面的回滚方案，包括缓存回滚、搜索引擎回滚、消息补偿、统计修正等。

    说明：原则上禁止在 **XxxxServcice** 类名上直接应用 @Transactional 注解。

10. **[参考]** **MyBatis** <isEqual>中的 compareValue 是与属性值对比的常量，一般是数字，表示相等时带上此条件 ； <isNotEmpty    表示不为空且不为 null 时执行 ； <isNotNull    表示不为 null 值时执行。

