#!/bin/bash
# ======================================================================================
# chmod u+x /opt/nginx/cut_nginx_log.sh
# crontab -e
# 0 0 * * * /home/tinywan/bin/cut_nginx_log.sh > /home/tinywan/bin/cut_nginx_log.log 2>&1
# =======================================================================================

LOGS_PATH="/usr/local/nginx/logs"
YEAR=$(date -d "yesterday" "+%Y")
MONTH=$(date -d "yesterday" "+%m")
# 获取昨天的日期
DATE=$(date -d "yesterday" "+%Y%m%d_%H%M%S")
echo "YEAR : ${YEAR} MONTH : ${MONTH} DATE :${DATE}"
# Nginx的master 主进程号 
NGINX_PID="/var/run/nginx.pid"
# -r 检测文件是否可读，如果是，则返回 true
if [ -r ${NGINX_PID} ]; then
    mkdir -p "${LOGS_PATH}/${YEAR}/${MONTH}"
    mv "${LOGS_PATH}/access.log" "${LOGS_PATH}/${YEAR}/${MONTH}/access_${DATE}.log"
    kill -USR1 $(cat "/var/run/nginx.pid")
    sleep 1
    gzip "${LOGS_PATH}/${YEAR}/${MONTH}/access_${DATE}.log"
    echo 'Nginx Cut Log Success'
else
    echo "Nginx might be down"
fi
# ==============================================================================
# Clean up log files older than 100 days
# ==============================================================================
# Change HOUSEKEEPING=1 to enable clean up
HOUSEKEEPING=0     
KEEP_DAYS=100
if [ $HOUSEKEEPING == 1 ]; then         # 删除日志开关，开关为1的时候才会去根据设置的天数删除压缩日志文件
    if [ -d "${LOGS_PATH}" ]; then
        find "${LOGS_PATH}" -type f -name "*.log.gz" -mtime +${KEEP_DAYS} -exec rm -f {} \;
    fi
fi
