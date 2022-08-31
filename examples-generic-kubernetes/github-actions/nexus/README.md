![K8ssupport](https://badgen.net/badge/supported%20K8s%20release/1.22/cyan)
# Getting Started
We've included a basic deployment to help get started.
Consult with our [documentation](https://all.docs.genesys.com/PEC-DC/Current/DCPEGuide) for the full configuration and deployment details.

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
|-|-|-|
POSTGRES_ADDR| pgdb-dgt-postgresql.infra|Postgres address for digital
POSTGRES_USER|  postgres| Postgres admin account 
POSTGRES_PASSWORD| secret| Postgres admin password
nexus_db_user| nexus | Nexus DB user
nexus_db_password| nexus | Nexus DB password
nexus_gws_client_id| nexus_client|Client ID for communicating with GAUTH service
nexus_gws_client_secret| secret|Client ID secret
nexus_redis_password| redPASS| REDIS password
tenant_id| 9350e2fc-a1dd-4c65-8d40-1f75a2e080dd| Tenant CCID
tenant_locations| westus1| Tenant location detail
tenant_primary_location| USW1| Tenant location
tenant_sid| 100| Tenant short-id

An example `.yaml`
```
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: deployment-secrets
  namespace: nexus
stringData:
  POSTGRES_ADDR: pgdb-dgt-postgresql.infra
  POSTGRES_USER: postgres
  POSTGRES_PASSWORD: secret
  nexus_db_user: nexus
  nexus_db_password: nexus
  nexus_gws_client_id: nexus_client
  nexus_gws_client_secret: secret
  nexus_redis_password: redPASS
  tenant_id: 9350e2fc-a1dd-4c65-8d40-1f75a2e080dd
  tenant_locations: westus1
  tenant_primary_location: USW1
  tenant_sid: 100
```

## Additional Information

Our sample configurations include the optional monitoring capabilities. For implementation of dashboards and monitoring see the [tools section](/tools).

Be sure to check your ingress details as per [ingress documentation](/doc/ingress.md).

Our sample configurations segment databases as per [database details](/doc/DATABASE.md).