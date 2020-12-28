#!/bin/bash
# ======================================================================================
# chmod u+x /opt/nginx/cut_multiple_nginx_log.sh
# crontab -e
# 0 0 * * * /home/tinywan/bin/cut_multiple_nginx_log.sh > /home/tinywan/bin/cut_nginx_log.log 2>&1
# =======================================================================================

LOGS_PATH="/usr/local/nginx/logs"     # 注意这里在路径末尾多个"/"
YEAR=$(date -d "yesterday" "+%Y")
MONTH=$(date -d "yesterday" "+%m")
# 获取昨天的日期
DATE=$(date -d "yesterday" "+%Y%m%d_%H%M%S")
echo "YEAR : ${YEAR} MONTH : ${MONTH} DATE :${DATE}"
# Nginx的master 主进程号 
NGINX_PID="/var/run/nginx.pid"
# -r 检测文件是否可读，如果是，则返回 true
CUT_LOG(){
    if [ -r ${NGINX_PID} ]; then
            mkdir -p "${LOGS_PATH}/${YEAR}/${MONTH}"
            cd ${LOGS_PATH}
            for i in $(ls *.log)                         # i = access.log/error.log/...等等
            do
                FILE_NAME=$(echo ${i} | sed 's/\.log//')  # FILE_NAME=access/error/...等等
                echo ${FILE_NAME}
                mv "${LOGS_PATH}/${i}" "${LOGS_PATH}/${YEAR}/${MONTH}/${FILE_NAME}_${DATE}.log"
                sleep 1
                gzip "${LOGS_PATH}/${YEAR}/${MONTH}/${FILE_NAME}_${DATE}.log"
            done
            kill -USR1 $(cat "/var/run/nginx.pid")
            echo 'Nginx Cut Log Success'
    else
        echo "Nginx might be down"
        exit 1
    fi
}
CUT_LOG
# ==============================================================================
# Clean up log files older than 100 days
# ==============================================================================
# Change HOUSEKEEPING=1 to enable clean up
HOUSEKEEPING=1
KEEP_DAYS=100
if [ $HOUSEKEEPING == 1 ]; then
    if [ -d "${LOGS_PATH}" ]; then
        find "${LOGS_PATH}" -type f -name "*.log.gz" -mtime +${KEEP_DAYS} -exec rm -f {} \;
    fi
fi