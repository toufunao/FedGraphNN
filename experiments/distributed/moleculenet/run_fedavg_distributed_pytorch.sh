#!/usr/bin/env bash


echo 'ip list :'
ipList="10.244.52.7 10.244.36.13 10.244.37.7 10.244.44.7 10.244.50.7 10.244.53.7 10.244.45.8 10.244.43.7 10.244.48.8 10.244.41.7 10.244.56.7 10.244.55.7"
for i in $ipList; do
    echo "updating $i"
    ssh $i "cd /opt/FedGraphNN/ ; git pull "
done



CLIENT_NUM=$1
WORKER_NUM=$2
SERVER_NUM=$3
GPU_NUM_PER_SERVER=$4
MODEL=$5
DISTRIBUTION=$6
PARTITION_ALPHA=$7
ROUND=$8
EPOCH=$9
BATCH_SIZE=${10}
LR=${11}
HIDDEN_DIM=${12}
NODE_DIM=${13}
DR=${14}
READ_DIM=${15}
GRAPH_DIM=${16}
DATASET=${17}
FL_ALG=${18}
MPI_HOST_FILE=${19:-mpi_host_file}
PROCESS_NUM=`expr $WORKER_NUM + 1`
if [ ! -n "$MPI_HOST_FILE" ]; then
  echo 'use default mpi_host_file'
  MPI_HOST_FILE='mpi_host_file'
fi
echo 'using MPI_HOST_FILE :'  $MPI_HOST_FILE
echo 'processor number :'  $PROCESS_NUM
echo 'Start to run mpi'


#hostname > mpi_host_file

mpirun -np $PROCESS_NUM -hostfile ./$MPI_HOST_FILE python3 main_fedavg.py \
  --gpu_server_num $SERVER_NUM \
  --gpu_num_per_server $GPU_NUM_PER_SERVER \
  --model $MODEL \
  --dataset $DATASET \
  --hidden_size $HIDDEN_DIM \
  --node_embedding_dim $NODE_DIM \
  --dropout $DR \
  --readout_hidden_dim $READ_DIM \
  --graph_embedding_dim $GRAPH_DIM \
  --partition_method $DISTRIBUTION  \
  --partition_alpha $PARTITION_ALPHA \
  --client_num_in_total $CLIENT_NUM \
  --client_num_per_round $WORKER_NUM \
  --comm_round $ROUND \
  --epochs $EPOCH \
  --fl_algorithm $FL_ALG \
  --batch_size $BATCH_SIZE \
  --lr $LR 
