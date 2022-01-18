#!/usr/bin/env bash

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

PROCESS_NUM=`expr $WORKER_NUM + 1`
echo $PROCESS_NUM
echo 'Start to run mpi'

#hostname > mpi_host_file

mpirun -np $PROCESS_NUM -hostfile ./mpi_host_file python3 main_fedavg.py \
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
