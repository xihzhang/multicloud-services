function get_secret {
  # Using: get_secret secret_name
  echo $( kubectl get secrets deployment-secrets -o custom-columns=:data.$1 \
      --no-headers | base64 -d )
}

###############################################################################
#             MS SQL connection information and credentials
###############################################################################
export gvp_mssql_db_server=$( get_secret gvp_mssql_db_server )
export gvp_rs_mssql_db_name=$( get_secret gvp_rs_mssql_db_name )
export gvp_rs_mssql_db_password=$( get_secret gvp_rs_mssql_db_password )
export gvp_rs_mssql_db_user=$( get_secret gvp_rs_mssql_db_user )
export gvp_rs_mssql_admin_password=$( get_secret gvp_rs_mssql_admin_password )
export gvp_rs_mssql_reader_password=$( get_secret gvp_rs_mssql_reader_password )
###############################################################################


echo "Waiting for mssql pod running state"
        for i in {1..36}; do
          echo "waiting running state.." && sleep 5
          s=$(kubectl get pods -o wide | grep  mssql-deployment | awk '{print $2}')
          [[ "$(echo $s | sed 's/\/.*//')" == "$(echo $s | sed 's/.*\///')" ]] && break
          [[ $i == 12 ]] && echo "ERROR: mssql-deployment pods not started" && exit 1
        done
        echo "mssql-deployment pods in are running"

kubectl create job init-mssql-for-gvp-rs-job --image=mcr.microsoft.com/mssql-tools -- \
sh -c "cat <<EOF | /opt/mssql-tools/bin/sqlcmd -S $gvp_mssql_db_server -U sa -P $gvp_rs_mssql_admin_password -i /dev/stdin -o /dev/stdout               
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'gvp_rs')
BEGIN
  CREATE DATABASE [gvp_rs];
END;
GO

CREATE LOGIN mssqladmin WITH PASSWORD = '$gvp_rs_mssql_admin_password';
EXEC sp_defaultdb 'mssqladmin', 'gvp_rs';  
GO

USE [gvp_rs];
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'mssqladmin')
BEGIN
    CREATE USER [mssqladmin] FOR LOGIN [mssqladmin]
    EXEC sp_addrolemember N'db_owner', N'mssqladmin'
END;
GO

CREATE LOGIN mssqlreader WITH PASSWORD = '$gvp_rs_mssql_reader_password';
EXEC sp_defaultdb 'mssqlreader', 'gvp_rs'; 
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'mssqlreader')
BEGIN
    CREATE USER [mssqlreader] FOR LOGIN [mssqlreader]
    EXEC sp_addrolemember N'db_datareader', N'mssqlreader'
END;
GO

SELECT name,create_date from sys.server_principals WHERE type in ('s', 'u');
GO
"
