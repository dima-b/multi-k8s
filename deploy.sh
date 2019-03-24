docker build -t mityab/multi-client:latest -t mityab/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mityab/multi-server:latest -t mityab/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mityab/multi-worker:latest -t mityab/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mityab/multi-client:latest
docker push mityab/multi-server:latest
docker push mityab/multi-worker:latest

docker push mityab/multi-client:$SHA
docker push mityab/multi-server:$SHA
docker push mityab/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mityab/multi-server:$SHA
kubectl set image deployments/client-deployment client=mityab/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mityab/multi-worker:$SHA
