![K8ssupport](https://badgen.net/badge/supported%20K8s%20release/1.22/cyan)
# Getting Started
We've included a basic deployment to help get started.
Consult with our [documentation](https://all.docs.genesys.com/AUTH/Current/AuthPEGuide/Overview) for the full configuration and deployment details.

## TL;DR
- Complete the prequisites if any.
- Adjust the `chart.ver` to the release you wish to deploy.
- Adjust the `override_values.yaml` to suit your environment and needs.
- Create the required secrets.
- Run the github actions workflow.

## Configuration

Be sure to update the values defined to align with your environment.
To use the scripting for service deployment, create a deployment secret (`deployment-secrets`) to store confidential information you may not want held in your repository, or `.yaml` files. 

*Note!* The example includes a Java KeyStore to use [JSON Web Token authentication](https://all.docs.genesys.com/AUTH/Current/AuthPEGuide/Configure). Replace the `<key content>` variable found within the `override_values.yaml`.

```
  auth:
    jks:
      keyStoreFileData: <key content>	
```

## Secrets 
Create the standard [pullsecret](../#-considerations) for the workflow: 
`secrets/pullsecret`

Create the following secrets to store confidential information you may not want held in your repository, or `.yaml` files. 
`secrets/deployment_secrets`

|:key: Key|:memo: Default value|:book: Description
|-|-|-
POSTGRES_ADDR|pgdb-gws-postgresql.infra.svc.cluster.local| Postgres address for GWS/GAUTH
DB_NAME|gauth| GAUTH DB name
POSTGRES_USER|postgres| Postgres admin account 
POSTGRES_PASSWORD|secret| Postgres admin password 
gauth_pg_password|gauth| GAUTH DB password
gauth_pg_username|gauth| GAUTH DB user
gauth_redis_password|redPass|REDIS password
gauth_admin_password|`$2y$10$a5znBNI3dr5q38jreJAj/ew/bdtpWDZ3FooLIBYMwxmlTU6Qm3qKy`| GAUTH admin password **bcrypt encoded**
gauth_admin_username|ops| GAUTH admin user
gauth_gws_client_id|gauth_client| Client ID for communicating with GAUTH service
gauth_gws_client_secret|`$2y$10$a5znBNI3dr5q38jreJAj/ew/bdtpWDZ3FooLIBYMwxmlTU6Qm3qKy`| Client ID secret **bcrypt encoded**
gauth_jks_keyPassword|keyPass| key password
gauth_jks_keyStorePassword|keyStorePass| keystore password
LOCATION|/USW1|Location setting

An example `.yaml`
```
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: deployment-secrets
  namespace: gauth
stringData:
  POSTGRES_ADDR: pgdb-gws-postgresql.infra.svc.cluster.local
  DB_NAME: gauth
  gauth_pg_username: gauth
  gauth_pg_password: gauth
  gauth_redis_password: redPass
  gauth_admin_username: ops
  gauth_admin_password: $2y$10$a5znBNI3dr5q38jreJAj/ew/bdtpWDZ3FooLIBYMwxmlTU6Qm3qKy
  gauth_gws_client_id: gauth_client
  gauth_gws_client_secret: $2y$10$a5znBNI3dr5q38jreJAj/ew/bdtpWDZ3FooLIBYMwxmlTU6Qm3qKy
  gauth_jks_keyPassword: keyPass 
  gauth_jks_keyStorePassword: keyStorePass
  LOCATION: /USW1
```
## Additional Information

Our sample configurations include the optional monitoring capabilities. For implementation of dashboards and monitoring see the [tools section](/tools).

Be sure to check your ingress details as per [ingress documentation](/doc/ingress.md).

Our sample configurations segment databases as per [database details](/doc/DATABASE.md).