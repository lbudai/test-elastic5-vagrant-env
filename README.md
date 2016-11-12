# test-elastic5-vagrant-env

Create an environment for testing syslog-ng with Elasticsearch 5

## start the environment
`vagrant up`

## test with syslog-ng

### example syslog-ng conf

```
@version: 3.8
@include "scl.conf"

source s_file {
        file("/tmp/input.log");
};

destination d_elastic {
elasticsearch2 ( 
        cluster("es-syslog-ng")
        client_mode("http")
        index("t440s")
        port("9200")
        server("192.168.33.10")
        type("slng_test_type")
        flush_limit("1")
)
};

log {
        source(s_file);
        destination(d_elastic);
        flags(flow-control);
};

```

### start syslog-ng (3.8.1)
```
stentor@T440s:~/work/github.lbudai/test-elastic5 $ 
syslog-ng -Fevdt -f syslog-ng.conf -R /tmp/syslog-ng-es5.persist -c /tmp/syslog-ng-es5.ctl -p /tmp/syslog-ng-es5.pid
```

### send message
```
stentor@T440s:~/work/github.lbudai/test-elastic5 $ logger -s MSG-$RANDOM -t logger 2>&1 |tee -a /tmp/input.log
<13>Nov 12 12:35:04 logger: MSG-21645
```

### check
```
 stentor@T440s:~/work/github.lbudai/test-elastic5 $ curl -XGET 'http://192.168.33.10:9200/_search/?q=MESSAGE:"MSG-21645"'
```

```
{"took":4,"timed_out":false,"_shards":{"total":5,"successful":5,"failed":0},"hits":{"total":1,"max_score":1.4486202,"hits":[{"_index":"t440s","_type":"slng_test_type","_id":"AVhYUcxOBYJGzjmFj_5N","_score":1.4486202,"_source":{"PROGRAM":"logger","PRIORITY":"notice","MESSAGE":"MSG-21645","ISODATE":"2016-11-12T12:35:04+01:00","HOST":"T440s","FACILITY":"user","@timestamp":"2016-11-12T12:35:04+01:00"}}]}}%
```
