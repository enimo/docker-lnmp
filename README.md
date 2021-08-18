A modified docker LNMP base on [helingfeng](https://github.com/helingfeng/Docker-LNMP) version.

### 第一步，安装依赖工具

- Git  // brew install git
- Docker [https://docs.docker.com/install/]
- Docker-compose [https://docs.docker.com/compose/install/#install-compose]

### 第二步，获取项目代码

```
$ git clone https://github.com/enimo/docker-lnmp.git
```
    
### 第三步，运行容器编排

```
$ cd docker-lnmp   // 进入项目根目录
$ docker-compose up -d   // 容器编排命令
```
启用服务，第一次需要构建镜像，有一定耗时。
P.S.: 或者在远程镜像仓库（腾讯云/阿里云）拉取已经构建完成的镜像: nginx, php73, redis, mysql, portainer(5个即可)


### 第四步，测试服务访问

http://127.0.0.1:9001 （访问 Docker GUI 管理工具 Portainer）

http://127.0.0.1:9002/ （默认首页，可配置80端口，可配置跳转HTTPS或者使用宿主机加HTTPS代理）

<!-- https://127.0.0.1/  （HTTPS, 由于证书不安全，所以需要点击继续访问） -->

http://127.0.0.1:9002/phpmyadmin/ （访问 phpmyadmin 管理工具，需提前解压www/目标下的phpmyadmin.zip包）

http://127.0.0.1:9002/phpredis （访问 phpredis 管理工具，需提前解压www/目标下的phpredis.zip包）

http://127.0.0.1:9003/  （访问 [Laravel](https://github.com/enimo/laravel8) 服务，有需要可单独安装；依赖项：`配置.env/certs, 初始化数据库`）

http://127.0.0.1:9005/ （访问 CMS 生成和管理工具 [Strapi](https://github.com/strapi/strapi)，可自动生成CMS相关API；注：`首次启动可能较慢，需编译一次`）

### `CLI` 运行模式（内置服务）

- 首先，自定义构建 `PHP-CLI` 镜像，安装 `Git`，`Composer`，`Swoole` 等扩展和工具

```shell
# 构建镜像
docker build -t php2-cli ./php-cli/php72
```

- 启动 `Demo` 示例

```shell
# cd your_project_path
cd www/demo

# 运行服务 `demo` 项目
docker run -it --rm --name www-demo \
    -p 8001:8001 \
    -v "$PWD":/usr/workspaces/project \
    -w /usr/workspaces/project \
    php2-cli \
    php -S 0.0.0.0:8001
```

- 启动 `Laravel` 示例

```shell
# cd your_project_path
cd project

# composer install
docker run -it --rm --name www-laravel \
    -v "$PWD":/usr/workspaces/project \
    -w /usr/workspaces/project \
    php2-cli \
    composer install

# php aritsan cache:clear
docker run -it --rm --name www-laravel \
    -v "$PWD":/usr/workspaces/project \
    -w /usr/workspaces/project \
    php2-cli \
    php artisan cache:clear
    
# php artisan serve
docker run -it --rm --name www-laravel \
    -p 8001:8001 \
    -v "$PWD":/usr/workspaces/project \
    -w /usr/workspaces/project \
    php2-cli \
    php artisan serve --host=0.0.0.0 --port=8001
```

- 启动 `Laravel-Swoole` 示例

```
# 配置 host 要修改为 0.0.0.0
# php artisan serve
docker run -it --rm --name www-laravel \
    -p 1215:1215 \
    -v "$PWD":/usr/workspaces/project \
    -w /usr/workspaces/project \
    php2-cli \
    php artisan swoole:http start
```

### Redis 集群配置

编排容器 Redis1-Redis6 使用 redis-cluster.yml 配置文件
```shell
docker-compose -f docker-compose-redis-cluster.yml up -d
```

进入 Redis1 命令行模式，执行创建集群命令
```shell
redis-cli -a CKuTkdUAT_HManA8 --cluster create 175.100.0.61:6381 \
  175.100.0.62:6382 \
  175.100.0.63:6383 \
  175.100.0.64:6384 \
  175.100.0.65:6385 \
  175.100.0.66:6386 \
  --cluster-replicas 1

...
[OK] All nodes agree about slots configuration.
>>> Check for open slots...
>>> Check slots coverage...
[OK] All 16384 slots covered.
```

使用 Redis-Cli 客户端操作 Redis 集群
```shell
redis-cli -p 6381 -a CKuTkdUAT_HManA8 -c
127.0.0.1:6381> get key
-> Redirected to slot [12539] located at 175.100.0.63:6383
(nil)
175.100.0.63:6383> 
```
