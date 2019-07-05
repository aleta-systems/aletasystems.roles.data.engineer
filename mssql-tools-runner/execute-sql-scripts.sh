#!/bin/bash

basepathSqlScripts='/tsqlscripts'

# Execute Master Scripts
printf "[PROCESS | Sql Files for (Master) DataBase]\n"
for tsqlFile in `find $basepathSqlScripts -wholename "$basepathSqlScripts/master/*.sql"`; do
    
    printf "\t|/opt/mssql-tools/bin/sqlcmd -S db -d master -U sa -i \"$tsqlFile\" ;\n"
    /opt/mssql-tools/bin/sqlcmd -S db -d master -U sa -P "$SA_PASSWORD" -i "$tsqlFile";

done

# Execute User Database Files | 1:1 | Database:Folder
for dbName in `find $basepathSqlScripts ! -path "$basepathSqlScripts" -type d -printf "%f\n"`; do

    printf "[PROCESS | Sql Files for ($dbName) DataBase]\n"
    
    shopt -s nocasematch
    if([[ $dbName != "master" ]]) then
        
        # Create Database IF NOT EXISTS
        queryStatement="IF DB_ID('[$dbName]') IS NOT NULL CREATE DATABASE [$dbName];\n"
        q=$(printf "$queryStatement")
        printf "\t| TRY CREATE DATABASE $dbName\n"
        printf "\t\t|/opt/mssql-tools/bin/sqlcmd -S db -d master -U sa -P $SA_PASSWORD -q \"$q\" ;\n"
        
        /opt/mssql-tools/bin/sqlcmd -S db -d master -U sa -P "$SA_PASSWORD" -q "$q";


        # Execute Database Specific Files
        printf "\t| Execute SqlFile $dbName\n"
        for tsqlFile in `find $basepathSqlScripts/$dbName/*.sql`; do

            printf "\t\t|/opt/mssql-tools/bin/sqlcmd -S db -d $dbName -U sa -i \"$tsqlFile\" ;\n"
            /opt/mssql-tools/bin/sqlcmd -S db -d $dbName -U sa -P "$SA_PASSWORD" -i "$tsqlFile";
        
        done
    fi
    shopt -u nocasematch
done