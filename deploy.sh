docker build -t matthiasjensen/multi-client:latest -t matthiasjensen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t matthiasjensen/multi-server:latest -t matthiasjensen/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t matthiasjensen/multi-worker:latest -t matthiasjensen/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push matthiasjensen/multi-client:latest
docker push matthiasjensen/multi-server:latest
docker push matthiasjensen/multi-worker:latest

docker push matthiasjensen/multi-client:$SHA
docker push matthiasjensen/multi-server:$SHA
docker push matthiasjensen/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=matthiasjensen/multi-server:$SHA
kubectl set image deployments/client-deployment client=matthiasjensen/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=matthiasjensen/multi-worker:$SHA