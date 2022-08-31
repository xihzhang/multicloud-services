![K8ssupport](https://badgen.net/badge/supported%20K8s%20release/1.22/cyan)
# Getting Started
We've included a basic deployment to help get started.
Consult with our [documentation](https://all.docs.genesys.com/GWS/Current/GWSPEGuide) for the full configuration and deployment details.

## TL;DR
- Complete the prequisites if any.
- Adjust the `chart.ver` to the release you wish to deploy.
- Adjust the `override_values.yaml` to suit your environment and needs.
- Create the required secrets.
- Run the github actions workflow.

## Configuration

Be sure to update the values defined to align with your environment.
To use the scripting for service deployment, create a deployment secret (`deployment-secrets`) to store confidential information you may not want held in your repository, or `.yaml` files. 

### Notes


## Secrets 
Create the standard [pullsecret](../#-considerations) for the workflow: 
`secrets/pullsecret`

Create the following secrets to store confidential information you may not want held in your repository, or `.yaml` files. 
`secrets/deployment_secrets`


|:key: Key|:memo: Default value|:book: Description
|-|-|-
gws_redis_password|redpass|REDIS password
gws_consul_token|1234567890|Consul bootstrap token
POSTGRES_ADDR|pgdb-gws-postgresql.infra|Postgres address
POSTGRES_USER|postgres|Postgres DB admin user
POSTGRES_PASSWORD|secret|Postgres DB admin password
DB_NAME_GWS|gws| GWS DB name
gws_pg_user|gws| GWS DB postgres user
gws_pg_pass|gws| GWS DB postgres password
DB_NAME_PROV|prov|GWS provisioning DB name
gws_as_pg_user|prov| GWS provisioning postgres user
gws_as_pg_pass|prov| GWS provisioning postgres password
gws_app_provisioning|secret|Client secret for `gws_app_provisioning`
gws_app_workspace|secret|Client secret for `gws_app_workspace`
gws_client_id|external_api_client| Client ID to be used for other applications
gws_client_secret|secret|Client secret for `gws_client_id`
gws_ops_user|ops| GWS operations user
gws_ops_pass_encr|| Encrypted password of the operational user **bcrypt encoded**
ES_ADDR| elastic-es-http.infra|Elasticsearch address
REDIS_ADDR| infra-redis-redis-cluster.infra|REDIS address
LOCATION| /USW1| Location setting

Example `.yaml`

```
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: deployment-secrets
  namespace: gws
stringData:
    gws_redis_password: redpass
    gws_consul_token: 1234567890
    POSTGRES_USER: postgres
    POSTGRES_PASSWORD: secret
    gws_pg_user: gws
    gws_pg_pass: gws
    gws_as_pg_user: prov
    gws_as_pg_pass: prov
    gws_app_provisioning: secret
    gws_app_workspace: secret
    gws_client_id: external_api_client
    gws_client_secret: secret
    gws_ops_user: ops
    gws_ops_pass_encr: <Encrypted password of the operational user **bcrypt encoded**>
    POSTGRES_ADDR: pgdb-gws-postgresql.infra
    DB_NAME_GWS: gws
    DB_NAME_PROV: prov
    ES_ADDR: elastic-es-http.infra
    REDIS_ADDR: infra-redis-redis-cluster.infra
    LOCATION: /USW1
```

## Additional Information

Our sample configurations include the optional monitoring capabilities. For implementation of dashboards and monitoring see the [tools section](/tools).

Be sure to check your ingress details as per [ingress documentation](/doc/ingress.md).

Our sample configurations segment databases as per [database details](/doc/DATABASE.md).