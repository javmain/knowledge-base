#ElasticSearch安装和运行

----------

`ElasticSearch`（后简称`ES`）官网地址：[https://www.elastic.co/](https://www.elastic.co/ "https://www.elastic.co/")
### 1. ElasticSearch介绍 
ElasticSearch是一个基于Lucene的搜索服务器。它提供了一个分布式多用户能力的全文搜索引擎，基于RESTful web接口。Elasticsearch是用Java开发的，并作为Apache许可条款下的开放源码发布，是当前流行的企业级搜索引擎。设计用于云计算中，能够达到实时搜索，稳定，可靠，快速，安装使用方便。

### 2. ElasticSearch逻辑构成
ElasticSearch 在逻辑上可分为3部分：索引(Index)、类型(Type) 和 文档(Document)，

ElasticSearch的构成与关系数据库对比：
<table  class="table table-bordered table-condensed">  
    <tr>  
        <td>关系数据库</td>  
    	<td>库(Databases)</td>  
		<td>表(Tables)</td>  
		<td>行(Rows)</td>  
		<td>列(Columns)</td>  
    </tr>  
    <tr>  
        <td>Elasticsearch</td>  
    	<td>索引(Indices)</td> 
		<td>类型(Types)</td>  
		<td>文档(Documents)</td>  
		<td>字段(Fields)</td>  
    </tr>  
</table>

### 3. ElasticSearch的存储构成

1. 节点(Node)
	<br>运行了单个实例的ES主机称为节点，它是集群的一个成员，可以存储数据、参与集群索引及搜索操作。类似于集群，节点靠其名称进行标识。用户可以按需要自定义任何希望使用的名称，但出于管理的目的，此名称应该尽可能有较好的识别性。节点通过为其配置的ES集群名称确定其所要加入的集群。

2. 分片(Shard)和副本(Replica)
<br>“分片(shard)”机制可将一个索引内部的数据分布地存储于多个节点，它通过将一个索引切分为多个底层物理的Lucene索引完成索引数据的分割存储功能，这每一个物理的Lucene索引称为一个分片(shard)。
<br><br>Shard有两种类型：primary和replica，即主shard及副本shard。Primary shard用于文档存储，每个新的索引会自动创建5个Primary shard，当然此数量可在索引创建之前通过配置自行定义，不过，一旦创建完成，其Primary shard的数量将不可更改。Replica shard是Primary Shard的副本，用于冗余数据及提高搜索性能。每个Primary shard默认配置了一个Replica shard，但也可以配置多个，且其数量可动态更改。ES会根据需要自动增加或减少这些Replica shard的数量。
3. 集群(cluster)
<br>集群就是很多节点（Node）的集合

### 4. ElasticSearch的安装


1. 下载地址：[https://www.elastic.co/downloads/elasticsearch](https://www.elastic.co/downloads/elasticsearch "https://www.elastic.co/downloads/elasticsearch")
2. 安装和运行
<br>`linux`   *./bin/elasticsearch*
<br>`windows`  进入安装目录下的 `bin`目录，运行*elasticsearch.bat*
3. 检查运行环境
<br>浏览器中输入:[http://localhost:9200/ ](http://localhost:9200/  "http://localhost:9200/ ")
，可以看到运行状态
    
    	{
    	  "name" : "node-1",
    	  "cluster_name" : "es-5.0-test",
    	  "cluster_uuid" : "iXvNe4qYTK6Sh4cF_Y094Q",
    	  "version" : {
    		"number" : "5.0.1",
    		"build_hash" : "080bb47",
    		"build_date" : "2016-11-11T22:08:49.812Z",
    		"build_snapshot" : false,
    		"lucene_version" : "6.2.1"
    	  },
    	  "tagline" : "You Know, for Search"
    	} 
    


### 5. Head插件的安装


1. 详细安装过程可以参考网址：[http://www.cnblogs.com/xuxy03/p/6039999.html](http://www.cnblogs.com/xuxy03/p/6039999.html "http://www.cnblogs.com/xuxy03/p/6039999.html")。
<br>可能遇到的问题：ES5.X 与 ES2.X对于Head插件的安装是不一样的。在ES5.X中，Head是一个独立的服务了，不再寄生在ES内部。安装时候还需要安装nodejs、platphomjs，grunt等相关组件，不再像ES2.X中一个命令就安装完成。

2. 运行
<br>启动head服务，cd到head的安装目录，执行命令：*grunt server*
3. 访问
<br>在浏览器中输入：[http://localhost:9100/ ](http://localhost:9100/  "http://localhost:9100/ ")

### 6. Kinba工具的安装
`Kibana`可以用报表的形式展现ES服务器的各种状态；同时还能提供基于json（DSL）方式的REST查询（原`Sense`工具功能）

1. 下载地址：[https://www.elastic.co/downloads/kibana](https://www.elastic.co/downloads/kibana "https://www.elastic.co/downloads/kibana")

2. 运行
<br>`linux`   
<br>`windows`  进入安装目录下的 `bin`目录，双击*kibana.bat*
3. 访问
<br>浏览器中：[http://localhost:5601](http://localhost:5601 "http://localhost:5601")
<br>基于json的DSL查询，可参考：[http://www.cnblogs.com/yjf512/p/4897294.html](http://www.cnblogs.com/yjf512/p/4897294.html "http://www.cnblogs.com/yjf512/p/4897294.html")


> 之前ES2.x和Kibana配合还需要使用plugin安装一些Marvel，sense等，现在都不需要了，`DevTools`就是之前的Sense工具

### 7. IK分词的安装
1. 装IK分词的原因（实际项目中会使用Hanlp，目前Hanlp分词的插件还不能支持最新版的ES。此处以IK为例，其他分词类似）
<br>测试ES自带分词的效果，浏览器中输入：[http://localhost:9200/_analyze?analyzer=standard&pretty=true&text=我是中国人](http://localhost:9200/_analyze?analyzer=standard&pretty=true&text=我是中国人 "http://localhost:9200/_analyze?analyzer=standard&pretty=true&text=我是中国人")
<br>会发现文本被分为一个个的汉字，自带的standard分词对中文不够友好。

2. IK分词的安装
<br>下载地址（版本与ES的版本要严格匹配）：[https://github.com/medcl/elasticsearch-analysis-ik/releases](https://github.com/medcl/elasticsearch-analysis-ik/releases "https://github.com/medcl/elasticsearch-analysis-ik/releases")
<br>解压缩，然后拷贝到ES下_pligin目录（需要自建IK目录）
3. IK5.X 介绍
<br>从版本5.0开始ik的tokenizer发生了变化，提供了两种分词器，一种为`ik_smart`，一种为`ik_max_word`。`ik_max_word`会尽量从输入中拆分出更多的词汇；而`ik_smart`则相反。实际上，`ik_max_word`就是原来低于5.0版本的`ik`，`ik_smart`是新增的。

4. 测试分词效果（注意`analyzer=XXX`跟标准分词的区别）
<br>输入网址：[http://localhost:9200/_analyze?analyzer=ik_max_word&pretty=true&text=我是中国人](http://localhost:9200/_analyze?analyzer=ik_max_word&pretty=true&text=我是中国人 "http://localhost:9200/_analyze?analyzer=ik_max_word&pretty=true&text=我是中国人")
<br>同理，[http://localhost:9200/_analyze?analyzer=ik_smart&pretty=true&text=我是中国人](http://localhost:9200/_analyze?analyzer=ik_smart&pretty=true&text=我是中国人 "http://localhost:9200/_analyze?analyzer=ik_smart&pretty=true&text=我是中国人")
5. `ES5.X` 与 `ES2.X` 在安装`IK`分词上的区别
<br>`ES2.X`安装分词器直接在config中修改配置文件进行配置。
<br>`ES5.X`只能在建立索引（index）的时候进行分词设置（程序建索引 或者restful访问建立），使用`Kibana`的`DevTools`工具设置IK分词如下：
    
    	PUT news{"settings" : 
		{
	        "index" : {
	            "number_of_shards" : 3, 
	            "number_of_replicas" : 2,
	            "analysis" : {
		            "analyzer" : {
		                "ik" : {
		                    "tokenizer" : "ik_max_word"
		                		}
		            		}
	        			}
	        		}
				}
		}
    


###8. 与Springboot工程的集成

1. 引入jar包
<br>elasticsearch.jar的版本在写DEMO时自动引入是还停留在2.3，因此使用指定版本强行引入，否则程序会出现版本不匹配。后续maven仓库更新包后应该会提升版本。
	
		compile (group: 'org.elasticsearch.client', name: 'transport', version:'5.1.1'){
					exclude group: 'org.elasticsearch', module: 'elasticsearch'
				}	
		compile 'org.elasticsearch:elasticsearch:5.1.1'

		compile 'org.apache.logging.log4j:log4j-api:2.7'
		compile 'org.apache.logging.log4j:log4j-core:2.7'
		compile 'org.apache.logging.log4j:log4j-jcl:2.7'
		compile 'org.slf4j:jcl-over-slf4j:1.7.12
 
2. 配置文件
<br>Application.properties文件中添加如下参数：
    
		example.elasticsearch.clusterName=es-5.0-test
		example.elasticsearch.ip=127.0.0.1
		example.elasticsearch.port=9300
读入配置参数的Bean

	    @Component
	    @ConfigurationProperties(prefix = "example.elasticsearch")
	    public class EsConf {
		    private String clusterName;
		    private String ip;
		    private Integer port;
		
		    public String getClusterName() {
		        return clusterName;
		    }
		
		    public void setClusterName(String clusterName) {
		        this.clusterName = clusterName;
		    }
		
		    public String getIp() {
		        return ip;
		    }
		
		    public void setIp(String ip) {
		        this.ip = ip;
		    }
		
		    public Integer getPort() {
		        return port;
		    }
		
		    public void setPort(Integer port) {
		        this.port = port;
		    }
	    }
    
3. ES客户端的建立，生成单例`Bean`

		@Configuration
		public class EsClientFactory {
		    @Autowired
		    private EsConf conf;//提示错误，实际上没有错误。详情：http://www.bubuko.com/infodetail-1881633.html
		
		    @Bean(name="esClient")
		    public Client getESClient() {
		        Client client = null;
		        // 配置信息
		        Settings settings = Settings.builder()
		                   .put("cluster.name", conf.getClusterName())// 集群名
		                .put("client.transport.sniff", true)
		                // 自动把集群下的机器添加到列表中
		                .build();
		
		        try {
		            client = new PreBuiltTransportClient(settings)
		                    .addTransportAddress(new InetSocketTransportAddress(InetAddress.getByName(conf.getIp()), conf.getPort()));
		
		        } catch (UnknownHostException e) {
		            e.printStackTrace();
		        }
		        return client;
		    }
		}

4. ES客服端向ES服务器写入一条数据的例子
	
		@RestController
		@RequestMapping("/one")
		public class HelloController {
			@Resource(name = "esClient")
			Client client;
		
		    /**
		     * 插入到index为“twitter”的索引里面，其document为“tweet”，id为“1”。
		     *
		     */
		    @RequestMapping(value = "insertdoc")
		    public  String insertDoc() {
		        Map<String, Object> map = new HashMap<String, Object>();
		        map.put("news_id", "1");
		        map.put("tag", "轨道五号线5109标九龙坡区段主体工程完工");
		        map.put("postDate", new Date());
		        map.put("content", "不能在配置文件中配置生效了，而由建立索引的时候进行指定分词，可以具体到某个字段");
		
		        IndexResponse response = client
		                .prepareIndex("news", "cq", "2").setSource(map)
		                .execute().actionGet();
		
		        return "insertdoc";
		    }
		}

5. 搜索查询
<br>查询方式主要分两类： `term`查询 和 `match` 查询。
<br>`match`：匹配的时候，会将查询的关键字进行分词，然后根据分词后的结果进行查询。
<br>`term`：直接使用关键字进行查询，不对关键字进行分词。
<br>具体操作请查询官网API文档：[https://www.elastic.co/guide/en/elasticsearch/client/java-api/current/index.html](https://www.elastic.co/guide/en/elasticsearch/client/java-api/current/index.html "https://www.elastic.co/guide/en/elasticsearch/client/java-api/current/index.html")
 



