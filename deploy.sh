docker build -t ferand81/multi-client:latest -t ferand81/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ferand81/multi-server:latest -t ferand81/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ferand81/multi-worker:latest -t ferand81/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ferand81/multi-client:latest
docker push ferand81/multi-server:latest
docker push ferand81/multi-worker:latest

docker push ferand81/multi-client:$SHA
docker push ferand81/multi-server:$SHA
docker push ferand81/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ferand81/multi-server:$SHA
kubectl set image deployments/client-deployment client=ferand81/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ferand81/multi-worker:$SHA