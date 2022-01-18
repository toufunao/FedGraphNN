#!/usr/bin/env bash
echo 'start'
hostname > mpi_host_file

#mpirun -hostfile ./mpi_host_file -np 3 python main_fedavg_reg.py

mpirun -np 6 -hostfile ./mpi_host_file python3 main_fedavg.py \
  --gpu_server_num 1 \
  --gpu_num_per_server 1 \
  --model graphsage \
  --dataset "bbbp" \
  --data_dir "./../../../data/moleculenet/" \
  --hidden_size 256 \
  --node_embedding_dim 256 \
  --dropout 0.3 \
  --readout_hidden_dim 256 \
  --graph_embedding_dim 256 \
  --partition_method hetero  \
  --partition_alpha 0.6 \
  --client_num_in_total 5 \
  --client_num_per_round 5 \
  --comm_round 150 \
  --epochs 1 \
  --batch_size 1 \
  --lr 0.0015 \
  --ci 0

#python3 main_fedavg.py \
#  --gpu_server_num 1 \
#  --gpu_num_per_server 1 \
#  --model graphsage \
#  --dataset "bbbp" \
#  --data_dir "./../../../data/moleculenet/" \
#  --hidden_size 256 \
#  --node_embedding_dim 256 \
#  --dropout 0.3 \
#  --readout_hidden_dim 256 \
#  --graph_embedding_dim 256 \
#  --partition_method hetero  \
#  --partition_alpha 0.6 \
#  --client_num_in_total 5 \
#  --client_num_per_round 5 \
#  --comm_round 150 \
#  --epochs 1 \
#  --batch_size 1 \
#  --lr 0.0015 \
#  --ci 0