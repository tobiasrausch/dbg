# Login
./bin/oc login <kubernetes cluster url>
./bin/oc whoami
./bin/oc help

# Create project
./bin/oc new-project testflask --description="Test Flask" --display-name="testflask"
./bin/oc get projects

# Create pod
./bin/oc create -f openshift/flask/pod.yaml
./bin/oc get pods
./bin/oc logs flask

# Entering the running pod
./bin/oc rsh flask   # top shows gunicorn

# Simple port forwarding shows the welcome message of the webserver at http://localhost:8080
./bin/oc port-forward pod/flask 8080

# Delete the pod
./bin/oc delete pods flask
