spring 技术经验
spring简介：spring是Java的一个轻量级的Java 开发框架，能解决企业开发的复杂性（现在用spring MVC和spring boot  更简单，封装得更彻底），
◆目的：解决企业应用开发的复杂性  

◆功能：使用基本的JavaBean代替EJB，并提供了更多的企业应用功能 

◆范围：任何Java应用  简单来说，Spring是一个轻量级的控制反转（IoC）和面向切面（AOP）的容器框架。 

◆轻量——从大小与开销两方面而言Spring都是轻量的。完整的Spring框架可以在一个大小只有1MB多的JAR文件里发布。
并且Spring所需的处理开销也是微不足道的。此外，Spring是非侵入式的：典型地，Spring应用中的对象不依赖于Spring的特定类。

◆控制反转——Spring通过一种称作控制反转（IoC）的技术促进了松耦合。当应用了IoC，一个对象依赖的其它对象会通过被动的方式传递进来，
而不是这个对象自己创建或者查找依赖对象。你可以认为IoC与JNDI相反——不是对象从容器中查找依赖，而是容器在对象初始化时不等对象请求就主动将依赖传递给它。

◆面向切面——Spring提供了面向切面编程的丰富支持，允许通过分离应用的业务逻辑与系统级服务（例如审计（auditing）和事务（transaction）管理）进行内聚性的开发。应用对象只实现它们应该做的——完成业务逻辑——仅此而已。它们并不负责（甚至是意识）其它的系统级关注点，例如日志或事务支持。  

◆容器——Spring包含并管理应用对象的配置和生命周期，在这个意义上它是一种容器，你可以配置你的每个bean如何被创建——基于一个可配置原型（prototype），
你的bean可以创建一个单独的实例或者每次需要时都生成一个新的实例——以及它们是如何相互关联的。然而，Spring不应该被混同于传统的重量级的EJB容器，
它们经常是庞大与笨重的，难以使用。

◆框架——Spring可以将简单的组件配置、组合成为复杂的应用。在Spring中，应用对象被声明式地组合，典型地是在一个XML文件里。
Spring也提供了很多基础功能（事务管理、持久化框架集成等等），将应用逻辑的开发留给了你。
所有Spring的这些特征使你能够编写更干净、更可管理、并且更易于测试的代码。它们也为Spring中的各种模块提供了基础支持。

一般的Java项目分为service（业务层接口）,dao(持久层接口),Controller(控制层接口),层层调用太过于复杂，并且容易出错，每调用一次都要new一个对象，
而spring就是解决这样的问题，它可以在xml文件中配置相应的bean，各层逻辑都可以相互调用。

一些常用的注解：
@Service用于标注业务层组件
@Controller用于标注控制层组件
@Repository用于标注数据访问组件，即DAO组件
@Component泛指组件，当组件不好归类的时候，我们可以使用这个注解进行标注。
@Autowired自动注解，在接口前面标上@Autowired注释使得接口可以被容器注入
@Transactional事务回滚，主要指对数据库操作如果错误进行回滚
@RestController主要用于用于控制层组件，直接返回数据，而不是具体返回在哪个页面
@RequestMapping是一个用来处理请求地址映射的注解，可用于类或方法上，主要有 value， method两个属性，现在一般用
@GetMapping，@PutMapping，@PostMapping，@DeleteMapping等代替用更明确

spring中的xml，使用Spring框架我们无需再主类中实例化调用类，而是通过XML配置文件告诉主类我们将取出一个什么对象，通常我们称之为Bean，
只要在XML文件中配置好需要调用的Bean的信息，在程序一开始，Spring就帮你全部实例化在Spring容器中，当主类想调用一个Bean的时候，
不是实例化，而是根据相关XML配置，通过Java反射机制向容器索取一个需要的对象出来，等用完了还将返还给Spring容器。

Spring 依赖注入(DI)，bean 配置文件来声明bean并通过构造函数(constructor-arg标签)设置注入依赖。如：

<beans xmlns="http://www.springframework.org/schema/beans"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://www.springframework.org/schema/beans
http://www.springframework.org/schema/beans/spring-beans-2.5.xsd">

	<bean id="xxxx" class="xxxx.xxxx.xxxx.xxxx">
		<constructor-arg>
			<bean class="yyyy.yyyy.yyyy.yyyy" />
		</constructor-arg>
	</bean>

<bean id="yyyy" class="yyyy.yyyy.yyyy.yyyy" />
<bean id="xxxx" class="xxxx.xxxx.xxxx.xxxx" />

</beans>
通过一个构造函数注入一个 “yyyy” Bean 到 “xxxx” 对象。

在Spring IoC容器使用类就会被认为是“Bean”，并可在Spring bean的配置文件或者通过注解来声明。

Spring AOP (面向方面编程),pring AOP的模块化方面横切关注点。简单地说，就是一个拦截器拦截一些方法。
例如，当一个方法执行，Spring AOP 可以劫持一个执行的方法，在方法执行之前或之后添加额外的功能。
在Spring AOP中，有 4 种类型通知(advices)的支持：
通知(Advice)之前 - 该方法执行前运行
通知(Advice)返回之后 – 运行后，该方法返回一个结果
通知(Advice)抛出之后 – 运行方法抛出异常后，
环绕通知 – 环绕方法执行运行，结合以上这三个通知。

