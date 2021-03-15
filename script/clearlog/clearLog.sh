#!/usr/bin/env bash

start(){
    SCRIPT_DIR=`echo $(dirname $(readlink -f "$0"))`
    LOG_NAME_TEMPLATE=$SCRIPT_DIR/template.txt
    host=$(hostname)
    grep "$host" $LOG_NAME_TEMPLATE |while read line; 
    do
        
    done
    
}

