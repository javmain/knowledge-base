# elasticsearch

**删除所有数据** 

```
curl -XPOST -H 'content-type: application/json' http://dn112:9200/hl_test/news/_delete_by_query?conflicts=proceed&pretty \
-d '{
    "query" : {
        "match_all" : {}
    }
}'
```
