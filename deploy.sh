docker build -t christianharborow/multi-client:latest \
    -t christianharborow/multi-client:$SHA \ 
    -f ./client/Dockerfile ./client

docker build -t christianharborow/multi-server:latest \
    -t christianharborow/multi-server:$SHA \ 
    -f ./server/Dockerfile ./server

docker build -t christianharborow/multi-worker:latest \
    -t christianharborow/multi-worker:$SHA \ 
    -f ./worker/Dockerfile ./worker

docker push christianharborow/multi-client:latest
docker push christianharborow/multi-server:latest
docker push christianharborow/multi-worker:latest

docker push christianharborow/multi-client:$SHA
docker push christianharborow/multi-server:$SHA
docker push christianharborow/multi-worker:$SHA

kubectl apply -f k8s
# kubectl set image deployments/server-deployment server=christianharborow/multi-server:$SHA
# kubectl set image deployments/client-deployment client=christianharborow/multi-client:$SHA
# kubectl set image deployments/worker-deployment worker=christianharborow/multi-worker:$SHA

kubectl set image deployments/server-deployment server=rallycoding/multi-server
kubectl set image deployments/client-deployment client=rallycoding/multi-client
kubectl set image deployments/worker-deployment worker=rallycoding/multi-worker