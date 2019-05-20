# Build an image of mssql-tools
FROM mcr.microsoft.com/mssql-tools
LABEL Name=aletasystems.role.data.engineer Version=0.0.1
 
# CREATE:: Volume
RUN mkdir /tsqlscripts
VOLUME /tsqlscripts

