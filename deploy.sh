### Build images using production Dockerfile
# Specify muliple tags
GIT_SHA=$(git rev-parse HEAD)
# Build react-client image
docker build -t manmeetsingh87/factorial-project-react-client-k8s:$GIT_SHA -f ./react-client/Dockerfile ./react-client

# Build express-server image
docker build -t manmeetsingh87/factorial-project-express-server-k8s:$GIT_SHA -f ./express-server/Dockerfile ./express-server

# Build worker image
docker build -t manmeetsingh87/factorial-project-worker-k8s:$GIT_SHA -f ./worker/Dockerfile ./worker

### Push images

# Push latest tag images to docker hub
#docker push singhabhinav/factorial-project-react-client-k8s:latest
#docker push singhabhinav/factorial-project-express-server-k8s:latest
#docker push singhabhinav/factorial-project-worker-k8s:latest

# Push sha tag images to docker hub
docker push manmeetsingh87/factorial-project-react-client-k8s:$GIT_SHA
docker push manmeetsingh87/factorial-project-express-server-k8s:$GIT_SHA
docker push manmeetsingh87/factorial-project-worker-k8s:$GIT_SHA

### Deploy

# Apply k8s config
kubectl apply -f k8s

# Update react-client image
kubectl set image deployments/react-client-deployment react-client=manmeetsingh87/factorial-project-react-client-k8s:$GIT_SHA

# Update express-server image
kubectl set image deployments/express-server-deployment express-server=manmeetsingh87/factorial-project-express-server-k8s:$GIT_SHA

# Update worker image
kubectl set image deployments/worker-deployment worker=manmeetsingh87/factorial-project-worker-k8s:$GIT_SHA
