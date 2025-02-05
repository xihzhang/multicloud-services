![K8ssupport](https://badgen.net/badge/supported%20K8s%20release/1.22/cyan)
# Getting Started
We've included a basic deployment to help get started.
Consult with our [documentation](https://all.docs.genesys.com/IXN/Current/IXNPEGuide) for the full configuration and deployment details.

## TL;DR
- Complete the prequisites if any.
- Adjust the `chart.ver` to the release you wish to deploy.
- Adjust the `override_values.yaml` to suit your environment and needs.
- Create the required secrets.
- Run the github actions workflow.

## Configuration

Be sure to update the values defined to align with your environment.
To use the scripting for service deployment, create a deployment secret (deployment-secrets) to store confidential information you may not want held in your repository, or `.yaml` files. 

### Notes
1. The installation will not replace the DB schema if it already exists. (ixn-server-initdb-container)

Create the following secrets to store confidential information you may not want held in your repository, or `.yaml` files. 
- `secrets/pullsecret`
- `secrets/deployment_secrets`

## Secrets 

`secrets/deployment_secrets`

|:key: Key|:memo: Default value|:book: Description
|-|-|-|
POSTGRES_ADDR| pgdb-dgt-postgresql.infra |Postgres address for digital
POSTGRES_USER|  postgres| Postgres admin account 
POSTGRES_PASSWORD| secret| Postgres admin password
IXNDB| ixn-100| IXN DB name
IXN_NODE_DB| ixn-node-100|IXN tenant DB name
ixn_db_user| ixn | Username for IXNDB and IXN_NODE_DB
ixn_db_password| ixn| Password for IXNDB and IXN_NODE_DB
redis_password| redPASS| REDIS password
tenant_sid| "100"| Tenant short-id
tenant_id| 9350e2fc-a1dd-4c65-8d40-1f75a2e080dd| Tenant CCID


Example `.yaml`
```
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: deployment-secrets
  namespace: ixn
stringData:
  POSTGRES_ADDR: pgdb-dgt-postgresql.infra
  IXNDB: ixn-100
  IXN_NODE_DB: ixn-node-100
  POSTGRES_USER: pgAdminPASS
  POSTGRES_PASSWORD: pgAdminUSER
  ixn_db_user: ixnUSER
  ixn_db_password: ixnPASS
  redis_password: redPASS
  tenant_sid: "100"
  tenant_id: 9350e2fc-a1dd-4c65-8d40-1f75a2e080dd
```

## Additional Information

Our sample configurations include the optional monitoring capabilities. For implementation of dashboards and monitoring see the [tools section](/tools).

Be sure to check your ingress details as per [ingress documentation](/doc/ingress.md).

Our sample configurations segment databases as per [database details](/doc/DATABASE.md).