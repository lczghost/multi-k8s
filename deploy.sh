docker build -t lczmdr/multi-client:latest -t lczmdr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lczmdr/multi-server:latest -t lczmdr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lczmdr/multi-worker:latest -t lczmdr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lczmdr/multi-client:latest
docker push lczmdr/multi-server:latest
docker push lczmdr/multi-worker:latest

docker push lczmdr/multi-client:$SHA
docker push lczmdr/multi-server:$SHA
docker push lczmdr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lczmdr/multi-server:$SHA
kubectl set image deployments/client-deployment client=lczmdr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lczmdr/multi-worker:$SHA