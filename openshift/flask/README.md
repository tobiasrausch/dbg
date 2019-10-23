# Build docker container
docker build --rm --no-cache -t trausch/simple-flask:v1 docker/
docker login
docker push trausch/simple-flask:v1

# Run as a pod
./bin/oc create -f flask/pod.yaml
./bin/oc logs flask

# Simple port forwarding shows the welcome message of the webserver at http://localhost:8080
./bin/oc port-forward pod/flask 8080

