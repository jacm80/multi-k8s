docker build -t jacm80/multi-client:latest -t jacm80/multi-client:$SHA ./client/Dockerfile ./client
docker build -t jacm80/multi-server:latest -t jacm80/multi-server:$SHA ./server/Dockerfile ./server
docker build -t jacm80/multi-worker:latest -t jacm80/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push jacm80/multi-client:latest
docker push jacm80/multi-server:latest
docker push jacm80/multi-worker:latest

docker push jacm80/multi-client:$SHA
docker push jacm80/multi-server:$SHA
docker push jacm80/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jacm80/multi-server:$SHA
kubectl set image deployments/client-deployment client=jacm80/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jacm80/multi-worker:$SHA