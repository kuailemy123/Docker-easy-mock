### Easy Mock 
---
[Easy Mock ](https://github.com/easy-mock/easy-mock)是一个可视化，并且能快速生成模拟数据的持久化服务。


### 变量
---
- PORT=7300            服务端口
  MONGODB=localhost    mongodb 连接地址
  REDIS_PORT=6379      redis连接端口
  REDIS_HOST=localhost redis连接地址
  REDIS_PASSWORD=''    redis连接密码
  REDIS_DB=0           redis连接db

### 版本
---
- 1.6.0 (docker tags: 1.6.0, latest) : easy-mock 版本为1.6.0

### 配置文件
`config/default.json`
```
{
  "port": 7300,
  "host": "0.0.0.0",
  "pageSize": 30,
  "proxy": false,
  "db": "mongodb://localhost/easy-mock",
  "unsplashClientId": "",
  "redis": {
    "keyPrefix": "[Easy Mock]",
    "port": 6379,
    "host": "localhost",
    "password": "",
    "db": 0
  },
  "blackList": {
    "projects": [],
    "ips": []
  },
  "rateLimit": {
    "max": 1000,
    "duration": 1000
  },
  "jwt": {
    "expire": "14 days",
    "secret": "shared-secret"
  },
  "upload": {
    "types": [".jpg", ".jpeg", ".png", ".gif", ".json", ".yml", ".yaml"],
    "size": 5242880,
    "dir": "../public/upload",
    "expire": {
      "types": [".json", ".yml", ".yaml"],
      "day": -1
    }
  },
  "ldap": {
    "server": "",
    "bindDN": "",
    "password": "",
    "filter": {
      "base": "",
      "attributeName": ""
    }
  },
  "fe": {
    "copyright": "",
    "storageNamespace": "easy-mock_",
    "timeout": 25000,
    "publicPath": "/dist/"
  }
}
```

### 使用
---
```bash
docker run -tid --name easy-mock --restart=always -p 7300:7300 -e MONGODB=192.168.77.133 -e REDIS_HOST=192.168.77.133 lework/easy-mock:1.6.0
```

docker-compose
```bash
version: '3'
services:
  easy-redis:
    container_name: easy-redis
    hostname: easy-redis
    image: redis:4.0-alpine
    command: redis-server --appendonly yes
    network_mode: test
    volumes:
      - "/easymock/redis:/data"
    restart: always

  easy-mongodb:
    container_name: easy-mongodb
    hostname: easy-mongodb
    image: mongo:3.6.5-jessie
    network_mode: test
    volumes:
      - "/easymock/mongodb:/data/db"
    restart: always
    
  easy-mock:
    container_name: easy-mock
    hostname: easy-mock
    image: lework/easy-mock:1.6.0
    network_mode: test
    ports:
      - '7300:7300'
    depends_on:
      - easy-mongodb
      - easy-redis
    environment:
      - MONGODB=easy-mongodb
      - REDIS_HOST=easy-redis
    restart: always
```