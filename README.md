# dbg
dbg stuff

# Build docker container
docker build --rm --no-cache -t trausch/dbg:v1 docker/
docker login
docker push trausch/dbg:v1

# Create DBG pods
./bin/oc create -f dbg.yaml
./bin/oc get pods


