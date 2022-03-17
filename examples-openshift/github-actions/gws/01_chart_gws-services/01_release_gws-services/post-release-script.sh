###############################################################################
# Adding routes (specific for OpenShift)
# https://docs.openshift.com/container-platform/3.7/architecture/networking/routes.html
#
# it functions like kubernetes ingress using bult-in HAProxy
###############################################################################


oc create route edge --service=gws-app-provisioning-blue-srv \
	--hostname=prov.$domain --path /provisioning --port=http

oc create route edge --service=gws-ui-provisioning-blue-srv \
	--hostname=prov.$domain --path  /ui/provisioning --port=http