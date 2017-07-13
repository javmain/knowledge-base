# 数据库访问

## ORM映射

1 **[强制]** **MyBatis** 在表查询中，一律不要使用 * 作为查询的字段列表，需要哪些字段必须明确写明。

1. 增加查询分析器解析成本。
2. 增减字段容易与 resultMap 配置不一致。

2 **[强制]**  POJO 类的 **布尔** 属性不能加 is，要求在 resultMap 中进行字段与属性之间的映射。

> 说明：参见定义 POJO 类以及数据库字段定义规定，在 <resultMap>中 增加映射，是必须的。在 MyBatis Generator 生成的代码中，需要进行对应的修改。

3 **[强制]** **MyBatis** 不要用 resultClass 当返回参数，即使所有类属性名与数据库字段一一对应，也需要定义；反过来，每一个表也必然有一个与之对应。

> 说明：配置映射关系，使字段与 DO 类解耦，方便维护。

4 **[强制]** **MyBatis** 的`sql.xml`配置参数使用： `#{}`， `#param#` 不要使用`${}` 此种方式容易出现 SQL 注入。

5 **[强制]** **MyBatis** 不允许直接拿 HashMap 与 Hashtable 作为查询结果集的输出。

> 说明：resultClass="Hashtable"，会置入字段名和属性值，但是值的类型不可控。

7 **[强制]** 更新数据表记录时，必须同时更新记录对应的 `updatedAt` 字段值为当前时间。

> JPA中可以使用 `@LastModifiedDate` 注解自动实现此功能

8 **[推荐]** **MyBatis** 不要写一个大而全的数据更新接口，传入为 POJO 类，不管是不是自己的目标更新字段，都进行 `update table set c1=value1，c2=value2，c3=value3`； 这是不对的。执行SQL时，不要更新无改动的字段，一是易出错；二是效率低；三是增加 binlog 存储。

9 **[参考]** @Transactional 事务不要滥用。事务会影响数据库的QPS ，另外使用事务的地方需要考虑各方面的回滚方案，包括缓存回滚、搜索引擎回滚、消息补偿、统计修正等。

> 说明：原则上禁止在 **XxxxServcice** 类名上直接应用 @Transactional 注解。

10 **[参考]** **MyBatis** `<isEqual>` 中的 compareValue 是与属性值对比的常量，一般是数字，表示相等时带上此条件； `<isNotEmpty>` 表示不为空且不为 null 时执行； `<isNotNull>`表示不为 null 值时执行。

## JPA

1 **[强制]** 统一所有数据库表名和字段使用驼峰格式

> 注意：在PG中，当表名或字段名包含大写字符时整个表名或字段需要使用英文双引号包裹

2 **[强制]** 所有 `@Query` 和 `@NamedQuery` 语句统一到 `orm.xml` 配置文件中编写

> 说明：当 `orm.xml` 文件太大时，应对其进行拆分。

3 **[推荐]** 所有Entity的 `createdAt` 和 `updatedAt` 字段都添加 `@CreatedDate` 或 `@LastModifiedDate` 注解，Spring-data-jpa 将自动设置这两个字段的值

4 **[强制]** Service层不允许直接操作数据库，所有数据库操作统一到 Repository

5 **[强制]** 需要同时操作多个 Repository时，应在 Service 与 Repository 层中间加一个 Manager 层，在Manager 层中操作多个 Repository

6 **[强制]** Service层不允许在类上添加 @Transactional 注解，有多个 Repository 操作时应添加中间层 Manager，并在需要的方法上添加特定条件的 @Transactional 注解

7 **[强制]** 当在Repository 中需要注入 JdbcTemplate 或 EntityManager 等相关组件以编程实现对数据库的访问，应使用 interface XXXRepositoryCustom 加  XXXRepositoryImpl implements XXXRepositoryCustom 的形式。

```java
public interface HotArticleRepository extends JpaRepository<HotArticle, Integer>, HotArticleRepositoryCustom {
    List<HotArticle> findListByArticleIdAndCreatedAt(String articleId, LocalDateTime createdAt);
}

public interface HotArticleRepositoryCustom {
    List findListByDateBetween(LocalDateTime beginDate, LocalDateTime endDate, Integer total);
}

public class HotArticleRepositoryImpl implements HotArticleRepositoryCustom {
    @Autowired
    private EntityManager entityManager;

    @Override
    public List<HotArticle> findListByDateBetween(LocalDateTime beginDate, LocalDateTime endDate, Integer total) {
        Query query = entityManager.createNativeQuery("SELECT t AS count FROM HotArticle t WHERE t.date BETWEEN ?1 AND ?2 GROUP BY t.articleId, t.title ORDER BY t.count DESC LIMIT ?3", Object[].class);

        return query.getResultList();
    }
}
```

8 **[强制]** 不允许使用 Map、Object、Object[] 等不明确的容器型对象作为返回参数，参考 **POJO** 定义特定的 DO 对象。

> <strong style="color:red;">反例</strong>：

```java
List<Object[]> getCountByDate(LocalDate startTime, LocalDate endTime);
```


