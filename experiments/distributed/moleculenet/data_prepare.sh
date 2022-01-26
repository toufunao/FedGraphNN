#!/usr/bin/env bash
FILE=$1

echo 'ip list :'
ipList="10.244.52.7 10.244.36.13 10.244.37.7 10.244.44.7 10.244.50.7 10.244.53.7 10.244.45.8 10.244.43.7 10.244.48.8 10.244.41.7 10.244.56.7 10.244.55.7"
for i in $ipList; do
    echo "updating $i"
    ssh $i "cd /opt/FedGraphNN/data ; bash $FILE"
done