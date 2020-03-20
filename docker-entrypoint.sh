#!/bin/bash

java -jar /assets/schemaspy.jar -t pgsql11 \
-s public -db $db_name -u $db_user -p $db_password \
-host $db_host -o /usr/share/nginx/html \
-port $db_port \
-dp /assets/pgsql_driver.jar -vizjs

nginx