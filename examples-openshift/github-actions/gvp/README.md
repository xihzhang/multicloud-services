![K8ssupport](https://badgen.net/badge/supported%20K8s%20release/1.22/cyan)
# Getting Started
We've included a basic deployment to help get started.
Consult with our [documentation](https://all.docs.genesys.com/GVP/Current/GVPPEGuide/Overview) for the full configuration and deployment details.

## TL;DR
- Complete the prequisites if any.
- Adjust the `chart.ver` to the release you wish to deploy.
- Adjust the `override_values.yaml` to suit your environment and needs.
- Create the required secrets.
- Run the github actions workflow.


### Prerequisites

Additional manual steps before installation:


1. Database for GVP should be created in postgres `gvp_cm_pg_db_name` in `deployment-secrets`
2. Database for GVP-RS should be created in MS SQL `gvp_rs_mssql_db_name` in `deployment-secrets`
3. User with db_owner role for gvp-rs db should be created in MS SQL. `gvp_rs_mssql_admin_password` 
   
Example:
```
CREATE LOGIN mssql 
    WITH PASSWORD    = N'password_here',
    DEFAULT_DATABASE = [gvp_rs],
    CHECK_POLICY     = OFF,
    CHECK_EXPIRATION = OFF;
USE [gvp_rs];
GO
CREATE USER mssql FOR LOGIN mssql
GO
EXEC sp_addrolemember N'db_owner', N'mssql'

    GO
```
4. User with db_datareader role for gvp-rs db should be created in MS SQL. (gvp_rs_mssql_reader_password, gvp_rs_mssql_db_password, gvp_rs_mssql_db_user in deployment-secrets)

Example:
```
CREATE LOGIN mssqlreader 
    WITH PASSWORD    = N'password_here',
    DEFAULT_DATABASE = [gvp_rs],
    CHECK_POLICY     = OFF,
    CHECK_EXPIRATION = OFF;
USE [gvp_rs];
GO
CREATE USER mssqlreader FOR LOGIN mssqlreader
GO
EXEC sp_addrolemember N'db_datareader', N'mssqlreader'
GO
```



## Configuration

Be sure to update the values defined to align with your environment.
To use the scripting for service deployment, create a deployment secret (deployment-secrets) to store confidential information you may not want held in your repository, or `.yaml` files. 


## Secrets 
Create the standard [pullsecret](../#-considerations) for the workflow: 
`secrets/pullsecret`

Create the following secrets to store confidential information you may not want held in your repository, or `.yaml` files. 
`secrets/deployment_secrets`

|:key: Key|:memo: Default value|:book: Description
|-|-|-
gvp_cm_configserver_password|password|password for GVP configserver
gvp_cm_configserver_user|default|user for GVP configserver
gvp_pg_db_server|pgdb-std-postgresql.infra.svc.cluster.local|Postgres GVP DB address
gvp_cm_pg_db_name|gvp|Postgres GVP DB name
gvp_cm_pg_db_user|gvp|Postgres GVP DB user
gvp_cm_pg_db_password|gvp|Postgres GVP DB password
gvp_consul_token|abc123|Consul API token
gvp_mssql_db_server|mssql-deployment.infra.svc.cluster.local|MSSQL GVP reporting server DB address
gvp_rs_mssql_admin_password|password|MSSQL GVP RS admin password
gvp_rs_mssql_db_name|gvp_rs|MSSQL GVP RS DB name
gvp_rs_mssql_db_password|password|MSSQL GVP RS DB admin password
gvp_rs_mssql_db_user|sa|MSSQL GVP RS DB admin user
gvp_rs_mssql_reader_password|password|MSSQL GVP RS DB reader user password
POSTGRES_USER|postgres|Postgres admin user
POSTGRES_PASSWORD|secret|Postgres admin password

Example `.yaml`

```
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: deployment-secrets
  namespace: gvp
data:
  gvp_cm_configserver_password: password
  gvp_cm_configserver_user: default
  gvp_pg_db_server: pgdb-std-postgresql.infra.svc.cluster.local
  gvp_cm_pg_db_name: gvp
  gvp_cm_pg_db_password: gvp
  gvp_cm_pg_db_user: gvp
  gvp_consul_token: abc123
  gvp_mssql_db_server: mssql-deployment.infra.svc.cluster.local
  gvp_rs_mssql_admin_password: password
  gvp_rs_mssql_db_name: gvp_rs
  gvp_rs_mssql_db_password: password
  gvp_rs_mssql_db_user: sa
  gvp_rs_mssql_reader_password: password
  POSTGRES_USER: postgres
  POSTGRES_PASSWORD: secret
```
## Additional Information

Our sample configurations include the optional monitoring capabilities. For implementation of dashboards and monitoring see the [tools section](/tools).

Be sure to check your ingress details as per [ingress documentation](/doc/ingress.md).

Our sample configurations segment databases as per [database details](/doc/DATABASE.md).