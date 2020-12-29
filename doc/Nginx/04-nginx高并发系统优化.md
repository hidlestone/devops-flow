# 04-nginx高并发系统优化

### Socket优化
- Nginx
- 系统内核

### 文件优化
- Nginx
- 系统内核 

### 配置文件优化
- Nginx配置文件
- 内核配置文件      


### 一、Nginx 子进程允许打开的连接数：
```bash
worker_connections
```

### 二、系统内核    
[内核参数的优化](http://blog.csdn.net/moxiaomomo/article/details/19442737)  


### 三、实践优化配置           
编辑： `vim /etc/sysctl.conf`            
配置结果            
```bash
net.ipv4.tcp_max_tw_buckets = 6000
net.ipv4.ip_local_port_range = 1024    65000
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_syncookies = 1
net.core.somaxconn = 262144
net.core.netdev_max_backlog = 262144
net.ipv4.tcp_max_orphans = 262144
net.ipv4.tcp_max_syn_backlog = 262144
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_fin_timeout = 1
net.ipv4.tcp_keepalive_time = 30
```
执行命令使之生效：`/sbin/sysctl -p`       


### 四、配置文件优化
Nginx配置文件
```
user  www www;
worker_processes 8;
worker_cpu_affinity 00000001 00000010 00000100 00001000 00010000 00100000 01000000;
error_log  /www/log/nginx_error.log  crit;
pid        /usr/local/nginx/nginx.pid;
worker_rlimit_nofile 204800;

events
{
  use epoll;
  worker_connections 204800;
}

http
{
  include       mime.types;
  default_type  application/octet-stream;

  charset  utf-8;

  server_names_hash_bucket_size 128;
  client_header_buffer_size 2k;
  large_client_header_buffers 4 4k;
  client_max_body_size 8m;

  sendfile on;
  tcp_nopush     on;

  keepalive_timeout 60;

  fastcgi_cache_path /usr/local/nginx/fastcgi_cache levels=1:2
  keys_zone=TEST:10m
  inactive=5m;
  fastcgi_connect_timeout 300;
  fastcgi_send_timeout 300;
  fastcgi_read_timeout 300;
  fastcgi_buffer_size 64k;
  fastcgi_buffers 8 64k;
  fastcgi_busy_buffers_size 128k;
  fastcgi_temp_file_write_size 128k;
  fastcgi_cache TEST;
  fastcgi_cache_valid 200 302 1h;
  fastcgi_cache_valid 301 1d;
  fastcgi_cache_valid any 1m;
  fastcgi_cache_min_uses 1;
  fastcgi_cache_use_stale error timeout invalid_header http_500;

  open_file_cache max=204800 inactive=20s;
  open_file_cache_min_uses 1;
  open_file_cache_valid 30s;
  tcp_nodelay on;

  #gzip  on;
  gzip on;
  gzip_min_length 1k;
  gzip_buffes 16 64k;
  gzip_http_version 1.1;
  gzip_comp_level 6;
  gzip_types text/plain application/x-javascript text/css application/javascript text/javascript image/jpeg image/gif image/png application/xml application/json;
  gzip_vary on;
  gzip_disable "MSIE [1-6].(?!.*SV1)";
  
  index  index.php index.html index.htm;
  
  server
  {
      listen       8080;
      server_name  backup.aiju.com;
      root  /www/html/;  #这里的位置很重要，不要写在其它指令里面，我曾经就调试了好久才发现这个问题的

      location /status
      {
        stub_status on;
      }
  
      location ~ .*\.(html|htm|gif|jpg|jpeg|bmp|png|ico|txt|js|css)$ {
              #root /home/www/sansan-web/public;
              expires      3d;
      }

      location ~ ^/(status|ping)$
      {
              include fastcgi_params;
              fastcgi_pass unix:/var/run/php7.0.22-fpm.sock;
              fastcgi_param SCRIPT_FILENAME $fastcgi_script_name;
      }

      location = /favicon.ico {
          access_log off;
      }

      error_page  400 401 402 403 404  /40x.html;
      #location = /40x.html {
      #        root   html;
      #}

      error_page   500 501 502 503 504  /50x.html;
      location = /50x.html {
              root   html;
      }
  
      # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
      location ~ \.php$ {
            fastcgi_pass   unix:/var/run/php7.0.22-fpm.sock;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            include        fastcgi_params;
            fastcgi_buffer_size 128k;
            fastcgi_buffers 4 256k;
            fastcgi_busy_buffers_size 256k;
            fastcgi_connect_timeout 300;
            fastcgi_send_timeout 300;
            fastcgi_read_timeout 300;
       }

      location ~ .*\.(gif|jpg|jpeg|png|bmp|swf|js|css)$
      {
        expires      30d;
      }

      log_format  access  '$remote_addr - $remote_user [$time_local] "$request" '
      '$status $body_bytes_sent "$http_referer" '
      '"$http_user_agent" $http_x_forwarded_for';
      access_log  /www/log/access.log  access;
  }
} 
```

### 五、完整的内核优化配置
```
net.ipv4.ip_forward = 0
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.tcp_syncookies = 1
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
net.ipv4.tcp_max_tw_buckets = 6000
net.ipv4.tcp_sack = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_rmem = 4096        87380   4194304
net.ipv4.tcp_wmem = 4096        16384   4194304
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.core.netdev_max_backlog = 262144
net.core.somaxconn = 262144
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_max_syn_backlog = 262144
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_synack_retries = 1
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_fin_timeout = 1
net.ipv4.tcp_keepalive_time = 30
net.ipv4.ip_local_port_range = 1024    65000
```    

