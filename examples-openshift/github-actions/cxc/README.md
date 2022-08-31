![K8ssupport](https://badgen.net/badge/supported%20K8s%20release/1.22/cyan)
# Getting Started
We've included a basic deployment to help get started.
Consult with our [documentation](all.docs.genesys.com/PEC-OU/Current/CXCPEGuide) for the full configuration and deployment details.

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
Provisioning is provided by reinstalling cxc release (basically, it is installed twice: 01_release_cxc and 02_release_cxc)

Any changes made in `01_release_cxc/override_values.yaml`, must be repeated in `02_release_cxc/override_values.yaml`. 

## Secrets 
Create the standard [pullsecret](../#-considerations) for the workflow: 
`secrets/pullsecret`

Create the following secrets to store confidential information you may not want held in your repository, or `.yaml` files. 
`secrets/deployment_secrets`

|Key|Sample Value|Description
|-|-|-
POSTGRES_ADDR| pgdb-std-postgresql.infra | Postgres DB address used for CX Contact
POSTGRES_PASSWORD| secret | Postgres admin password
POSTGRES_USER| postgres | Postgres admin user
cxc_configserver_user_name| cxcUser | Define the system username for CX Contact
cxc_configserver_user_password| cxcPass |  Define the system password for CX Contact
cxc_gws_client_id| cx_contact| Name of the GWS service client to use
cxc_gws_client_secret| cx_contact| Secret for the GWS service client
cxc_prov_gwsauthpass| gwsUser| GWS provisioning password
cxc_prov_gwsauthuser| gwsPass| GWS provisioning user
cxc_prov_tenant_pass| password| Tenant account password
cxc_prov_tenant_user| default| Tenant account user
cxc_redis_password| redPass| redis cluster password
tenant_sid| "100"| Tenant short-id used in environment
tenant_id| 9350e2fc-a1dd-4c65-8d40-1f75a2e080dd| Tenant CCID used in the environment
tenant_primary_location| /USW1| Tenant location used in the environment

An example `.yaml`
```
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: deployment-secrets
  namespace: cxc
stringData:
  POSTGRES_ADDR: pgdb-std-postgresql.infra
  POSTGRES_PASSWORD: secret
  POSTGRES_USER: postgres
  cxc_redis_password: redPass
  cxc_configserver_user_name: cxcUser
  cxc_configserver_user_password: cxcPass
  cxc_gws_client_id: cx_contact
  cxc_gws_client_secret: cx_contact
  cxc_prov_gwsauthpass: gwsUser
  cxc_prov_gwsauthuser: gwsPass
  cxc_prov_tenant_user: default
  cxc_prov_tenant_pass: password
  tenant_sid: 100
  tenant_id: 9350e2fc-a1dd-4c65-8d40-1f75a2e080dd
  tenant_primary_location: /USW1

```


## Additional Information

Our sample configurations include the optional monitoring capabilities. For implementation of dashboards and monitoring see the [tools section](/tools).

Be sure to check your ingress details as per [ingress documentation](/doc/ingress.md).

Our sample configurations segment databases as per [database details](/doc/DATABASE.md).