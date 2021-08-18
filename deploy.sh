docker build -t stpiep/multi-client:latest -t stpiep/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stpiep/multi-server:latest -t stpiep/mutli-server:$SHA -f ./server/Dockerfile ./server
docker build -t stpiep/multi-worker:latest -t stpiep/mutli-worker:$SHA -f ./worker/Dockerfile ./worker

docker push stpiep/multi-client:latest
docker push stpiep/multi-server:latest
docker push stpiep/multi-worker:latest

docker push stpiep/multi-client:$SHA
docker push stpiep/multi-server:$SHA
docker push stpiep/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=stpiep/multi-client:$SHA
kubectl set image deployments/server-deployment server=stpiep/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=stpiep/multi-worker:$SHA
