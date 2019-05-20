#!/bin/bash
for filename in  /tsqlscripts/*.sql; do
    /opt/mssql-tools/bin/sqlcmd -S db -U sa -P C0mplexPassw0rd! -i "$filename" ;
done