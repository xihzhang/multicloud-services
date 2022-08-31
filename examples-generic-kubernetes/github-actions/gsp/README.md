![K8ssupport](https://badgen.net/badge/supported%20K8s%20release/1.22/cyan)
# Getting Started
We've included a basic deployment to help get started.
Consult with our [documentation](https://all.docs.genesys.com/PEC-REP/Current/GIMPEGuide/Overview) for the full configuration and deployment details.

## TL;DR
- Complete the prequisites if any.
- Adjust the `chart.ver` to the release you wish to deploy.
- Adjust the `override_values.yaml` to suit your environment and needs.
- Create the required secrets.
- Run the github actions workflow.

## Configuration

Be sure to update the values defined to align with your environment.
To use the scripting for service deployment, create a deployment secret (deployment-secrets) to store confidential information you may not want held in your repository, or `.yaml` files. 


## Secrets 
Create the standard [pullsecret](../#-considerations) for the workflow: 
`secrets/pullsecret`

Create the following secrets to store confidential information you may not want held in your repository, or `.yaml` files. 
`secrets/deployment_secrets`

|Key|Sample Value|Description
|-|-|-|
ACCESS_KEY_ID| access_key|s3 bucket access key ID
SECRET_ACCESS_KEY| secret_key|s3 bucket secret 
BUCKET_HOST| storage.googleapis.com| s3 bucket host
BUCKET_NAME| gca-gsp-storage-bucket| s3 bucket name
BUCKET_PORT|  443|s3 bucket port
KAFKA_ADDR| kafka-helm-cp-kafka.kafka|Kafka address

Example `.yaml`

```
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: deployment-secrets
  namespace: gsp
data:
  ACCESS_KEY_ID: access_key
  SECRET_ACCESS_KEY: secret_key
  BUCKET_HOST: storage.googleapis.com
  BUCKET_NAME: gca-gsp-storage-bucket
  BUCKET_PORT: 443
  KAFKA_ADDR: kafka-helm-cp-kafka.kafka

```



## Additional Information

Our sample configurations include the optional monitoring capabilities. For implementation of dashboards and monitoring see the [tools section](/tools).

Be sure to check your ingress details as per [ingress documentation](/doc/ingress.md).

Our sample configurations segment databases as per [database details](/doc/DATABASE.md).
